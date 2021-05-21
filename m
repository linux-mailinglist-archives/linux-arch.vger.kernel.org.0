Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCCA38C985
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 16:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbhEUOwM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 10:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232057AbhEUOwL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 10:52:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15C1761244;
        Fri, 21 May 2021 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621608648;
        bh=E5SzQf7ojZwGymmxW8Bc1NkGOtaRDaagBD9U0Qp0b/w=;
        h=From:To:Cc:Subject:Date:From;
        b=Grnf/yMvIW9dOoCQ8uwsNGREdpj2+0QcPA960wIWctSTfnA++cRMOTNwdA/n1C3rC
         wAxD3MFjrThBrxOW6cy+q1Ny3JFSQHWls3mWnuphSqHK9GIxnPOaalAGS/iIBxBzG6
         zKBViCcJhXMDc4jnABcEQy6Y6gzpbsDOqZEGXLsYvGUHduxD+bPYsicT5BwFckP7Gp
         S86I6L+ursESEq7kmyWEyngnRF5cs8dAByq1EbLiYaQp/V6qYonP7urhpyfbDcK12e
         DMuO34bI3Xm3DjSISBxjMIGccWgShB7tPkk+vxID5fkOoDa3XN6o9jMWD9+bom0Gnr
         d4tmkG21b8k2g==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, libc-alpha@sourceware.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/2] arm64: Enable BTI for the executable as well as the interpreter
Date:   Fri, 21 May 2021 15:46:19 +0100
Message-Id: <20210521144621.9306-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; h=from:subject; bh=E5SzQf7ojZwGymmxW8Bc1NkGOtaRDaagBD9U0Qp0b/w=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBgp8e52rx52kLo8ejZvd+0QpndI56sS+egfvpy0gFl 8tZS3YCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYKfHuQAKCRAk1otyXVSH0Ot5B/ 9aitjdhLxWBsekuYePmiJmZPaWIADO334zfYOAdSHJcD47YTrOcyg3Z8kxwjbNnG2ToLMD6z1cyvg9 mQ4GBWtwpTIFIpF7jW/QY3z6Fmj/r8XGCbZnuT1yt2f3mTbK37CeVaOspLlKzpI6TjdBWiCpBP0hQI PJLFaYGgJVIdbEQg6k6z9hCcw2a8ZLgmCJqTstPauqfZHr91Mqm2FiHPpAND9r2V/02OWPRFpugrqN +O1kdXvcK4kQVneMvUpnwL88qmHV1meWC7BgiyX13ObgXFCqIiedyJeFYVjPkAk+leFx6+AOjXaIkM OoPRUShYch582Q1TjhyftmKQjJYZYr
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Deployments of BTI on arm64 have run into issues interacting with
systemd's MemoryDenyWriteExecute feature.  Currently for dynamically
linked executables the kernel will only handle architecture specific
properties like BTI for the interpreter, the expectation is that the
interpreter will then handle any properties on the main executable.
For BTI this means remapping the executable segments PROT_EXEC |
PROT_BTI.

This interacts poorly with MemoryDenyWriteExecute since that is
implemented using a seccomp filter which prevents setting PROT_EXEC on
already mapped memory and lacks the context to be able to detect that
memory is already mapped with PROT_EXEC.  This series resolves this by
handling the BTI property for both the interpreter and the main
executable.

This does mean that we may get more code with BTI enabled if running on
a system without BTI support in the dynamic linker, this is expected to
be a safe configuration and testing seems to confirm that. It also
reduces the flexibility userspace has to disable BTI but it is expected
that for cases where there are problems which require BTI to be disabled
it is more likely that it will need to be disabled on a system level.

Mark Brown (2):
  elf: Allow architectures to parse properties on the main executable
  arm64: Enable BTI for main executable as well as the interpreter

 arch/arm64/include/asm/elf.h | 13 ++++++++++---
 arch/arm64/kernel/process.c  | 18 ++++++------------
 fs/binfmt_elf.c              | 25 +++++++++++++++++--------
 include/linux/elf.h          |  4 +++-
 4 files changed, 36 insertions(+), 24 deletions(-)


base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
-- 
2.20.1


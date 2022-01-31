Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D834A3DD8
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 07:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357764AbiAaGtx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 01:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347958AbiAaGtv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 01:49:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28017C06173B;
        Sun, 30 Jan 2022 22:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=G3eZFCktx2riD9Fj3jpqcTZpN3ouTd5tOKnvsSiUNyA=; b=MfXv6k0J576+bDzPKkd7XmOSk6
        Q7XFADAC+rGIOXNLxAiJprclkGI1atOQ+EUxxI1XOHDSFUTEB+n08NACzpmB7c/K5XUf6nOWW7ejJ
        NJ7KSXUKvKXa3MR/++aeuPRMGwq5OBa6pL8tbsJhs7gk3PVuGROtvO9X/XNfl51VGNNwp1FytN0J3
        X99/N1kFhFcMVB1wYK7lirZkjKe6HD0Uc4cECk2h6pvsnDrEzZNxmjrn04MBXOXcQKsakL+5BPby2
        z+1OXA3/T2MP9igSUyKllXpu1HyaJP0nCYf3rxjL9MW6aefNFPAKYlrvZt2i7y8Dcq8T9IZJQ2HLW
        iMASDxQg==;
Received: from [2001:4bb8:191:327d:13f5:1d0a:e266:6974] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEQVN-008AUM-0p; Mon, 31 Jan 2022 06:49:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: consolidate the compat fcntl definitions v2
Date:   Mon, 31 Jan 2022 07:49:28 +0100
Message-Id: <20220131064933.3780271-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

currenty the compat fcnt definitions are duplicate for all compat
architectures, and the native fcntl64 definitions aren't even usable
from userspace due to a bogus CONFIG_64BIT ifdef.  This series tries
to sort out all that.

Changes since v1:
 - only make the F*64 defines uapi visible for 32-bit architectures

Diffstat:
 arch/arm64/include/asm/compat.h        |   20 --------------------
 arch/mips/include/asm/compat.h         |   23 ++---------------------
 arch/mips/include/uapi/asm/fcntl.h     |   30 +++++-------------------------
 arch/parisc/include/asm/compat.h       |   16 ----------------
 arch/powerpc/include/asm/compat.h      |   20 --------------------
 arch/s390/include/asm/compat.h         |   20 --------------------
 arch/sparc/include/asm/compat.h        |   22 +---------------------
 arch/x86/include/asm/compat.h          |   24 +++---------------------
 include/linux/compat.h                 |   31 +++++++++++++++++++++++++++++++
 include/uapi/asm-generic/fcntl.h       |   23 +++++++++--------------
 tools/include/uapi/asm-generic/fcntl.h |   21 +++++++--------------
 11 files changed, 58 insertions(+), 192 deletions(-)

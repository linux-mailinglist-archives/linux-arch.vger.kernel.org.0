Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A49428AD
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2019 16:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409271AbfFLOV1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jun 2019 10:21:27 -0400
Received: from foss.arm.com ([217.140.110.172]:53910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409269AbfFLOV0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Jun 2019 10:21:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D86152B;
        Wed, 12 Jun 2019 07:21:25 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D4B33F557;
        Wed, 12 Jun 2019 07:21:24 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v4 0/2] arm64 relaxed ABI
Date:   Wed, 12 Jun 2019 15:21:09 +0100
Message-Id: <20190612142111.28161-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560339705.git.andreyknvl@google.com>
References: <cover.1560339705.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On arm64 the TCR_EL1.TBI0 bit has been always enabled on the arm64 kernel,
hence the userspace (EL0) is allowed to set a non-zero value in the top
byte but the resulting pointers are not allowed at the user-kernel syscall
ABI boundary.

This patchset proposes a relaxation of the ABI with which it is possible
to pass tagged tagged pointers to the syscalls, when these pointers are in
memory ranges obtained as described in tagged-address-abi.txt contained in
this patch series.

Since it is not desirable to relax the ABI to allow tagged user addresses
into the kernel indiscriminately, this patchset documents a new sysctl
interface (/proc/sys/abi/tagged_addr) that is used to prevent the applications
from enabling the relaxed ABI and a new prctl() interface that can be used to
enable or disable the relaxed ABI.

This patchset should be merged together with [1].

[1] https://patchwork.kernel.org/cover/10674351/

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
CC: Andrey Konovalov <andreyknvl@google.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>


Vincenzo Frascino (2):
  arm64: Define Documentation/arm64/tagged-address-abi.txt
  arm64: Relax Documentation/arm64/tagged-pointers.txt

 Documentation/arm64/tagged-address-abi.txt | 111 +++++++++++++++++++++
 Documentation/arm64/tagged-pointers.txt    |  23 +++--
 2 files changed, 127 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/arm64/tagged-address-abi.txt

-- 
2.21.0


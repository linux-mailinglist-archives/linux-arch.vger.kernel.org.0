Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFB88EFA2
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2019 17:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfHOPoM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Aug 2019 11:44:12 -0400
Received: from foss.arm.com ([217.140.110.172]:45736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729975AbfHOPoM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Aug 2019 11:44:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B08A21570;
        Thu, 15 Aug 2019 08:44:11 -0700 (PDT)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 032D33F706;
        Thu, 15 Aug 2019 08:44:09 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v8 2/5] arm64: Tighten the PR_{SET,GET}_TAGGED_ADDR_CTRL prctl() unused arguments
Date:   Thu, 15 Aug 2019 16:44:00 +0100
Message-Id: <20190815154403.16473-3-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0.rc0
In-Reply-To: <20190815154403.16473-1-catalin.marinas@arm.com>
References: <20190815154403.16473-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Require that arg{3,4,5} of the PR_{SET,GET}_TAGGED_ADDR_CTRL prctl and
arg2 of the PR_GET_TAGGED_ADDR_CTRL prctl() are zero rather than ignored
for future extensions.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 kernel/sys.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sys.c b/kernel/sys.c
index c6c4d5358bd3..ec48396b4943 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2499,9 +2499,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = PAC_RESET_KEYS(me, arg2);
 		break;
 	case PR_SET_TAGGED_ADDR_CTRL:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
 		error = SET_TAGGED_ADDR_CTRL(arg2);
 		break;
 	case PR_GET_TAGGED_ADDR_CTRL:
+		if (arg2 || arg3 || arg4 || arg5)
+			return -EINVAL;
 		error = GET_TAGGED_ADDR_CTRL();
 		break;
 	default:

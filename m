Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE76DD3518
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 02:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfJKAHN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 20:07:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40158 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfJKAG2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 20:06:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so4939836pfb.7
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2019 17:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bl12US5Yp4ZwWvaEnQTrcBCg3LoqQRPWnxt7WskOqWM=;
        b=MPX+iPjeGRBi9W7v8BaGtEQ7Z0gPfVJ+oEGukA1Qx5FZM3UbvHSgUUNTtJdbrvF0DJ
         Lniffb/JdJpDuc2hFDvI6xqzg3lDsRa6goVJDwHcZqncxHEEePqIwXD0wmcvebpFmc8f
         hOMnZpwmNvMPGn7QBG585RWKNTpfnKyDCS46Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bl12US5Yp4ZwWvaEnQTrcBCg3LoqQRPWnxt7WskOqWM=;
        b=MVw/f4cGrIGsNHrDH5YoJSTIc8Grnq1eOnxCWP7RY3Q0viAokXh/NXswA6Y3eDblfB
         dVg6BDsqVsUt6aidgBMFo5mORjl8kZW2XIvUUBKG5xj0mQoK4u90fCGmh3Gc/8U25hx9
         Y1fXiR3kLaM4bEcuwCnnnDsB6sID6h34m7H/PT8mL7QAc8lRndVPmFGNdp88zO0eIwAA
         j1T/4n8CS3puy0GSsdVjUp2oHFevq/sp8rwoiPzkDCMhEjPJVB3pvWMBLlV2iARjaX08
         RYDHnkSUig8x9JZ76jMXDmW+htIN4qRzDGMddoTBY8TygdAavQLtCUz/lvL0HARJDe6v
         LykQ==
X-Gm-Message-State: APjAAAUcxSRtyofmZU6ufrCsgY33sYSYm/U2NZ79yGfnRw/tt7+vFy7p
        8HAz5DzZwESQNQ/k08GFGhYC5w==
X-Google-Smtp-Source: APXvYqx/QRL/EGj1UNqOw9cSZc5qNyXaSBqEdm+ZR6Z42olkPMiWXRzScwFI4gnTT7Nu98OPft+Atg==
X-Received: by 2002:a17:90a:9318:: with SMTP id p24mr14062359pjo.31.1570752386117;
        Thu, 10 Oct 2019 17:06:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 6sm10807049pfa.162.2019.10.10.17.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:06:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/29] s390: Move RO_DATA into "text" PT_LOAD Program Header
Date:   Thu, 10 Oct 2019 17:05:46 -0700
Message-Id: <20191011000609.29728-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for moving NOTES into RO_DATA, move RO_DATA back into the
"text" PT_LOAD Program Header, as done with other architectures. The
"data" PT_LOAD now starts with the writable data section.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/s390/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 7e0eb4020917..13294fef473e 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -52,7 +52,7 @@ SECTIONS
 
 	NOTES :text :note
 
-	.dummy : { *(.dummy) } :data
+	.dummy : { *(.dummy) } :text
 
 	RO_DATA_SECTION(PAGE_SIZE)
 
@@ -64,7 +64,7 @@ SECTIONS
 	.data..ro_after_init : {
 		 *(.data..ro_after_init)
 		JUMP_TABLE_DATA
-	}
+	} :data
 	EXCEPTION_TABLE(16)
 	. = ALIGN(PAGE_SIZE);
 	__end_ro_after_init = .;
-- 
2.17.1


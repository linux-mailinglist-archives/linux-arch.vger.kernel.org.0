Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB74F484035
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 11:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiADK4n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 05:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiADK4m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 05:56:42 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEE7C061761;
        Tue,  4 Jan 2022 02:56:42 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id n30so34778453eda.13;
        Tue, 04 Jan 2022 02:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z5izaHa8Yu92LDDoFb1xPLy6Z706YGp0YBj7HbtCpUk=;
        b=BxgwrlZpM7nQianx7SwyYuhm23kC0LaKP/VWl+GvFpiW6hEJrjUMNqtliTZSuWU57q
         5b6TZGKb7h5hPOHzzGsueJLL2UwO0F/Z8GtVyrRWDn8vDIrrZESWOivnP5P3NF8Ro71g
         zRn8ET7LfKEDg6QlHj8VO67gjfkMzZXiFO7Dqrnk5M5AXZh/BLPIZSktLnFPHwGsKe2l
         NiMoozTplQtMrb+MvSwPxWLg0gUOggNyEMWh6UjQnDAdBvqbjIdUwmAEUTUrowXw5afk
         0NtH+sInSAnVM/VXzSg7HBMgeoAuHmaohNsCtjGo1CZd6wjHbCUyWMr3cGjCGDi+sIuz
         vsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=z5izaHa8Yu92LDDoFb1xPLy6Z706YGp0YBj7HbtCpUk=;
        b=i5oxAPF8SGL827qQuNv4wY77yJtF39cMw9/tI30XCr6qv5M6jZUjVkldh2FHuR14HN
         wXRAXEK4td5mL9t3T/62sDwur2lu1FemqFw0UOX0aF2Lhj1pfftJShGtSYY/KJcC2eY8
         ZWFFYu53QJCpUus75k3vmQU3Qr7lP75W7eRSbe/9koro2MMqIpiRKSJSgW2vOe9DiU9r
         B80lrDezsMfeLwVUX7130+WgpEAXKxo8WKrSvt/0n0mbM5jpEfe+MuxgbHPR7lXfwXXR
         1pzYJyLXwhXbGaKHdodiKEn/Xsvm6xcpxf0UnYLSNwMgqJ7mfGAxQdn56P6/Yd3GxnjS
         fsyw==
X-Gm-Message-State: AOAM532ifQMeoYLATTIsAJfRD/gHhxCZiZSCKmXqHwjjKtIjP6op6qKj
        CkHS1rFqKstQtnkmzDTN+2g=
X-Google-Smtp-Source: ABdhPJy8/Jr1RYDSn5PTcczK7FPK2eBXHF2KNo6Mn9CY46E6PfwlnHb/cHhlqNtMoDmofK5Tt8/G2g==
X-Received: by 2002:a17:906:888f:: with SMTP id ak15mr38530951ejc.0.1641293800985;
        Tue, 04 Jan 2022 02:56:40 -0800 (PST)
Received: from gmail.com (0526F11B.dsl.pool.telekom.hu. [5.38.241.27])
        by smtp.gmail.com with ESMTPSA id lv23sm11292605ejb.125.2022.01.04.02.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 02:56:40 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 4 Jan 2022 11:56:38 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>, llvm@lists.linux.dev
Subject: [DEBUG PATCH] DO NOT MERGE: Enable SHADOW_CALL_STACK on GCC builds,
 for build testing
Message-ID: <YdQn5kTyXUJmdH9r@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdQlwnDs2N9a5Reh@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > 2. Error with CONFIG_SHADOW_CALL_STACK
> 
> So this feature depends on Clang:
> 
>  # Supported by clang >= 7.0
>  config CC_HAVE_SHADOW_CALL_STACK
>          def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
> 
> No way to activate it under my GCC cross-build toolchain, right?
> 
> But ... I hacked the build mode on with GCC using this patch:
> 
> From: Ingo Molnar <mingo@kernel.org>
> Date: Tue, 4 Jan 2022 11:26:09 +0100
> Subject: [PATCH] DO NOT MERGE: Enable SHADOW_CALL_STACK on GCC builds, for build testing
> 
> NOT-Signed-off-by: Ingo Molnar <mingo@kernel.org>

Ok, I've attached patch again instead embedding it in the middle of a long 
discussion, for future reference.

Thanks,

	Ingo

=====================>
From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 4 Jan 2022 11:26:09 +0100
Subject: [PATCH] DO NOT MERGE: Enable SHADOW_CALL_STACK on GCC builds, for build testing

NOT-Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Makefile           | 2 +-
 arch/Kconfig       | 2 +-
 arch/arm64/Kconfig | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 16d7f83ac368..bbab462e7509 100644
--- a/Makefile
+++ b/Makefile
@@ -888,7 +888,7 @@ LDFLAGS_vmlinux += --gc-sections
 endif
 
 ifdef CONFIG_SHADOW_CALL_STACK
-CC_FLAGS_SCS	:= -fsanitize=shadow-call-stack
+CC_FLAGS_SCS	:=
 KBUILD_CFLAGS	+= $(CC_FLAGS_SCS)
 export CC_FLAGS_SCS
 endif
diff --git a/arch/Kconfig b/arch/Kconfig
index 4e56f66fdbcf..2103d9da4fe1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -605,7 +605,7 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
 
 config SHADOW_CALL_STACK
 	bool "Clang Shadow Call Stack"
-	depends on CC_IS_CLANG && ARCH_SUPPORTS_SHADOW_CALL_STACK
+	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
 	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
 	help
 	  This option enables Clang's Shadow Call Stack, which uses a
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4207cf9bb17..952f3e56e0a7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1183,7 +1183,7 @@ config ARCH_HAS_FILTER_PGPROT
 
 # Supported by clang >= 7.0
 config CC_HAVE_SHADOW_CALL_STACK
-	def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
+	def_bool y
 
 config PARAVIRT
 	bool "Enable paravirtualization code"

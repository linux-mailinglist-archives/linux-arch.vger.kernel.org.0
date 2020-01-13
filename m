Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 121281393A8
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2020 15:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgAMO11 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jan 2020 09:27:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgAMO11 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jan 2020 09:27:27 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CFC72073D;
        Mon, 13 Jan 2020 14:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578925646;
        bh=lDi3yhRp4PbF/E8j+iB9FGNiI7wABd2r9c3DUhzLcZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wkc4M0JI8URUydIBo+uimk/TWQjQKQTf3136LlrNh1UnY0vMI6s8zMP/j7qyJZvwV
         CiX/MHjFZUUbeBIKbAgwCQnjiZWJpqEADJkoam5OX2jj/y8hm8cPhTLlfxc8loY6eN
         a784eL6XoIt/Z4piiOxqlwe9TJPqDCZYsgSknflA=
Date:   Mon, 13 Jan 2020 14:27:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        masahiroy@kernel.org
Subject: Re: [RFC PATCH 1/8] compiler/gcc: Emit build-time warning for GCC
 prior to version 4.8
Message-ID: <20200113142720.GA4458@willie-the-truck>
References: <20200110165636.28035-1-will@kernel.org>
 <20200110165636.28035-2-will@kernel.org>
 <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[+Masahiro]

On Fri, Jan 10, 2020 at 06:35:02PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
> >
> > Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
> > discarding the 'volatile' qualifier:
> >
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> >
> > We've been working around this using some nasty hacks which make
> > READ_ONCE() both horribly complicated and also prevent us from enforcing
> > that it is only used on scalar types. Since GCC 4.8 is pretty old for
> > kernel builds now, emit a warning if we detect it during the build.
> 
> No objection to recommending gcc-4.8, but I think this should either
> just warn once during the kernel build instead of for every file, or
> it should become a hard requirement.

Oops, yes, good point. I blindly followed the '< 4.6' check, but that's
actually a '#error' so it doesn't have the issue you mention. I've had a
crack at moving the check into kbuild -- see below.

Will

--->8

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 62afe874073e..d7ee4c6bad48 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -14,10 +14,6 @@
 # error Sorry, your compiler is too old - please upgrade it.
 #endif
 
-#if GCC_VERSION < 40800
-# warning Your compiler is old and may miscompile the kernel due to https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 - please upgrade it.
-#endif
-
 /* Optimization barrier */
 
 /* The "volatile" is due to gcc bugs */
diff --git a/init/Kconfig b/init/Kconfig
index a34064a031a5..bdc2f1b1667b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -10,11 +10,11 @@ config DEFCONFIG_LIST
 	default "arch/$(ARCH)/defconfig"
 
 config CC_IS_GCC
-	def_bool $(success,$(CC) --version | head -n 1 | grep -q gcc)
+	def_bool $(cc-is-gcc)
 
 config GCC_VERSION
 	int
-	default $(shell,$(srctree)/scripts/gcc-version.sh $(CC)) if CC_IS_GCC
+	default $(gcc-version) if CC_IS_GCC
 	default 0
 
 config CC_IS_CLANG
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index d4adfbe42690..4e645a798b56 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -40,3 +40,9 @@ $(error-if,$(success, $(LD) -v | grep -q gold), gold linker '$(LD)' not supporte
 
 # gcc version including patch level
 gcc-version := $(shell,$(srctree)/scripts/gcc-version.sh $(CC))
+
+# Return y if the compiler is GCC, n otherwise
+cc-is-gcc := $(success,$(CC) --version | head -n 1 | grep -q gcc)
+
+# Warn if the compiler is GCC prior to 4.8
+$(warning-if,$(if-success,[ $(gcc-version) -lt 40800 ],$(cc-is-gcc),n),"Your compiler is old and may miscompile the kernel due to https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 - please upgrade it.")

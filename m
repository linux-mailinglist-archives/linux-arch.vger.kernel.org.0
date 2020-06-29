Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083B620DD6F
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 23:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgF2Syh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 14:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbgF2Sww (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:52:52 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9B7C031C7A;
        Mon, 29 Jun 2020 11:15:17 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z2so13590859qts.5;
        Mon, 29 Jun 2020 11:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ksn6KEgSSy4O04+EmiHmLNcv0njEAGgzFW6T11ji+vI=;
        b=Xjvp/RucTJD7ys4so77HqyBdKQg72774rOpK0Iy63xJF5nLNOOILQoRIXkvOl8GSiV
         +dq1LOTSqRzP649aH77rs+eXXLE6NrmWrR2ZfZCPcZIIXq+sCkRejxszABRcdazkcaLO
         sosTZdgioDe0Awvmhn8VQ9Xq7tdlEZdqFPTfi0ICfdG4ZOw15yRKYNYyr7GlNnUU/Jc6
         j+yXaf+nXfjR9kDYWQi3iHL2zZJ08F13kaTJcXndLsH6fIgDkpVttULkAJxaKMU4AZTG
         otU+pDZSB+sDNIHb74V0Qlsb3g2ppZAYET8gjxxd9JFf9PRwuZVBIXjVJQHbrkmo8MjZ
         lAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ksn6KEgSSy4O04+EmiHmLNcv0njEAGgzFW6T11ji+vI=;
        b=MMCFgfFy9XnVzlCnOmLXySRIJgDwwaAj3tfCJEP31d9kQcaS9N9s1aLPJeQJhQvxE+
         3SRMx35eiwg5VzdZH60FFBN5CbgZ5KcZobnftXPg3HbGkyoznqcd8lp5p9RThLhLr01h
         3NzspdNOa9bTIjExPT0NysjWKc/fTEqr4DWl0stTG7/Z9aV3cFLQbHgE09rj0NfZ1kEs
         naM2suTJS37VlRM7S8QUsUj2uBFy34PjijFIkeyC29bKWJepv99TJC/rpbV2t64K88ua
         q0uLpEwwqJ/QsgY/vak953jOQ9hJpK938DYmqNY+9YigJtuZQsEl9V90RUuhxKPl8ToV
         MhBw==
X-Gm-Message-State: AOAM532ECWZ/23VgLyHR8ClfLpqlvHPq6zguAWeTv/2/v5t3pFttUnoH
        +P6Lp7caVaj2RH1UsbMqys0=
X-Google-Smtp-Source: ABdhPJzHr+OXXpT2ladJEzyIUGa3Qh7oKbbNWJhQOzQ+NHJbTju9YGsvUo+VZ1jPBQ+dsZ58uYQ4Zw==
X-Received: by 2002:ac8:7242:: with SMTP id l2mr16374761qtp.320.1593454516576;
        Mon, 29 Jun 2020 11:15:16 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z17sm592545qth.24.2020.06.29.11.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:15:16 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 29 Jun 2020 14:15:14 -0400
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/17] arm/build: Warn on orphan section placement
Message-ID: <20200629181514.GA1046442@rani.riverdale.lan>
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-15-keescook@chromium.org>
 <20200629155401.GB900899@rani.riverdale.lan>
 <20200629180703.GX1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200629180703.GX1551@shell.armlinux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 29, 2020 at 07:07:04PM +0100, Russell King - ARM Linux admin wrote:
> On Mon, Jun 29, 2020 at 11:54:01AM -0400, Arvind Sankar wrote:
> > On Sun, Jun 28, 2020 at 11:18:37PM -0700, Kees Cook wrote:
> > > We don't want to depend on the linker's orphan section placement
> > > heuristics as these can vary between linkers, and may change between
> > > versions. All sections need to be explicitly named in the linker
> > > script.
> > > 
> > > Specifically, this would have made a recently fixed bug very obvious:
> > > 
> > > ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'
> > > 
> > > Discard unneeded sections .iplt, .rel.iplt, .igot.plt, and .modinfo.
> > > 
> > > Add missing text stub sections .vfp11_veneer and .v4_bx.
> > > 
> > > Add debug sections explicitly.
> > > 
> > > Finally enable orphan section warning.
> > 
> > This is unrelated to this patch as such, but I noticed that ARM32/64 places
> > the .got section inside .text -- is that expected on ARM?
> 
> Do you mean in general, in the kernel vmlinux, in the decompressor
> vmlinux or ... ?
> 

Sorry, in the kernel vmlinux. ARM_TEXT includes *(.got) for 32-bit, and
the 64-bit vmlinux.lds.S includes it in .text as well. The decompressor
for 32-bit keeps it separate for non-EFI stub kernel and puts it inside
.data for EFI stub.

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0CC48B8CB
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 14:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfHMMlj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 08:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbfHMMlh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 08:41:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E676720578;
        Tue, 13 Aug 2019 12:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565700096;
        bh=Jq/IQ6CWnFkPICRfKWG1UKe/f3JsG+a8LmqFboRXXbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXhgZMi0JXG3TruF3XZXJoQIHKKAUDX/coWvIPS7cALEvShPoCPOwZlIBmVcjMvOR
         YmmGks/LTYMmuOGO2LjjFBmvix1ub2opzf0WNnO14eryX0zxKllnqPVeVEtirq9N03
         dfO5vqGWOlLSm7jhT8ePDH10A0kl1klQELhsnqVc=
Date:   Tue, 13 Aug 2019 14:41:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, maco@android.com,
        kernel-team@android.com, arnd@arndb.de, geert@linux-m68k.org,
        hpa@zytor.com, jeyu@kernel.org, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@google.com, michal.lkml@markovi.net, mingo@redhat.com,
        oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org,
        sboyd@codeaurora.org, sspatil@google.com,
        stern@rowland.harvard.edu, tglx@linutronix.de,
        usb-storage@lists.one-eyed-alien.net, x86@kernel.org,
        yamada.masahiro@socionext.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v2 02/10] export: explicitly align struct kernel_symbol
Message-ID: <20190813124134.GB14284@kroah.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-3-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813121733.52480-3-maennich@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 13, 2019 at 01:16:59PM +0100, Matthias Maennich wrote:
> This change allows growing struct kernel_symbol without wasting bytes to
> alignment. It also concretized the alignment of ksymtab entries if
> relative references are used for ksymtab entries.
> 
> struct kernel_symbol was already implicitly being aligned to the word
> size, except on x86_64 and m68k, where it is aligned to 16 and 2 bytes,
> respectively.
> 
> As far as I can tell there is no requirement for aligning struct
> kernel_symbol to 16 bytes on x86_64, but gcc aligns structs to their
> size, and the linker aligns the custom __ksymtab sections to the largest
> data type contained within, so setting KSYM_ALIGN to 16 was necessary to
> stay consistent with the code generated for non-ASM EXPORT_SYMBOL(). Now
> that non-ASM EXPORT_SYMBOL() explicitly aligns to word size (8),
> KSYM_ALIGN is no longer necessary.
> 
> In case of relative references, the alignment has been changed
> accordingly to not waste space when adding new struct members.
> 
> As for m68k, struct kernel_symbol is aligned to 2 bytes even though the
> structure itself is 8 bytes; using a 4-byte alignment shouldn't hurt.
> 
> I manually verified the output of the __ksymtab sections didn't change
> on x86, x86_64, arm, arm64 and m68k. As expected, the section contents
> didn't change, and the ELF section alignment only changed on x86_64 and
> m68k. Feedback from other archs more than welcome.
> 
> Co-developed-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Matthias Maennich <maennich@google.com>

Ick, messy, nice fix.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

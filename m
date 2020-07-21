Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBBA228AFE
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 23:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbgGUVSx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 17:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbgGUVSw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 17:18:52 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA12C061794
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:18:52 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id l6so10792289plt.7
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oZ+JoLZ43wxde/v2pWNQdBZEy1k9AMtxsdeltF18Z30=;
        b=fOZplhzkfQjlmMs+fOOuHWAQH5KetgWFj/VhzU6eSu8vpND0m0V1TjB7faHy1uVoIa
         sZC4ttKuAEfqwYAq8Iu35cFDDvzYO2gjOwmE/6e8Ntj3StOFb5lCeFP9XVDQn4B8x528
         /Pwo508mh8yuA8uMG1/YVxp+HL2r0nOycSxXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oZ+JoLZ43wxde/v2pWNQdBZEy1k9AMtxsdeltF18Z30=;
        b=G9TEeFOlJx1S9M1Pp6wPD0Uzt01OrWm4Bun+sNIWHXI6q0lLnsgiHAmN9a4DreldAp
         waMU5uvQVo2bZzJrVkVPMs+JGz1+Uuw+w7zJ6OzbpQ4mBTq8SEDGShWOumKaa+YjFbLP
         US7gPHehAvn8K2FMjbCh1b33XRIDkTYsM2d+6WEHfU8z9UgI6g+5y4VUI5TmwgN6yqYA
         WBmYzmGZsIdvX2Tdlz1JDhHj6viSu4s6fk+MnqtdUZJfedjSFXfsrY31mCtzAE2bCEPt
         jLtCnqFzUHtsb7gh5lQhBUABDedJ3HTyxWBzYFW00Z6E8zaeXMsQbUvR6m+YI3QBvuQW
         gSxg==
X-Gm-Message-State: AOAM533jCeap7wnB9qy0u4Ns/+WNpAv+l+cm+TLqkisaVckBST8LRIMP
        gCuis2wGwuXt5Qhx4M93kGOcYg==
X-Google-Smtp-Source: ABdhPJz5PFwUqQLM2s2i11W2OpAjR8V3PUupz65U68wR4YNmFEEFoBSMVi6o9VV+D61gFDTdZgWxIQ==
X-Received: by 2002:a17:90a:70cd:: with SMTP id a13mr6768113pjm.89.1595366331967;
        Tue, 21 Jul 2020 14:18:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c71sm4448104pje.32.2020.07.21.14.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 14:18:51 -0700 (PDT)
Date:   Tue, 21 Jul 2020 14:18:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Bob Haarman <inglorion@google.com>, hjl.tools@gmail.com,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] x86, vmlinux.lds: Page-Align end of ..page_aligned
 sections
Message-ID: <202007211416.1A2B618DE@keescook>
References: <202007211143.AC36D096@keescook>
 <87r1t43a8e.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1t43a8e.fsf@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 10:05:05PM +0200, Thomas Gleixner wrote:
> Kees,
> 
> Kees Cook <keescook@chromium.org> writes:
> > On Tue, Jul 21, 2020 at 11:34:48AM +0200, Joerg Roedel wrote:
> >> From: Joerg Roedel <jroedel@suse.de>
> >> 
> >> Align the end of the .bss..page_aligned and .data..page_aligned section
> >> on page-size too. Otherwise the linker might place other objects on the
> >> page of the last ..page_aligned object. This is inconsistent with other
> >> objects in those sections, which all have their own page.
> >
> > What problem was actually encountered? (i.e. why is it a problem for the
> > other data to be in the page of the page-aligned data? shouldn't those
> > data have their own, separate, alignment hint?)
> 
> See: lore.kernel.org/r/87sgdmm8u4.fsf@nanos.tec.linutronix.de

Ah-ha: "But with explicit sections which store only page aligned objects
there is an implicit guarantee that the object is alone in the page
in which it is placed. That works for all objects except the last
one. That's inconsistent."

Understood now. The bit in this commit log for "which all have their own
page" wasn't clear to me about _why_ (it was coming from .page_aligned,
which means both aligned and dedicated).

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

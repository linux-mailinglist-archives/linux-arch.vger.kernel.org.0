Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1966313D04
	for <lists+linux-arch@lfdr.de>; Mon,  8 Feb 2021 19:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbhBHSQj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Feb 2021 13:16:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235390AbhBHSOg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Feb 2021 13:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612807989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vna1UpISDhhzy62RgmCODV7iVBrOXqSLXKC77p47hCA=;
        b=LyDZuhy3/HjZnQ9XW1+R10EzJ1it0mTLMHi1UEKCSAsqMx2Cw+scJ46m9DCOnDefxLyKmd
        AlPNJDr3+lGKiAmbQvh3LUxgAv3BnJq9JAEy0ImZ0Sj7sn0wnGy5tIOf+gNd99Tu1cof2N
        4SOb+Q/fS6eEDMVxegddrvui5QiQNDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-LIm0O2BmNA-BWgTWAaL5AQ-1; Mon, 08 Feb 2021 13:13:07 -0500
X-MC-Unique: LIm0O2BmNA-BWgTWAaL5AQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8B141936B65;
        Mon,  8 Feb 2021 18:13:04 +0000 (UTC)
Received: from treble (ovpn-118-142.rdu2.redhat.com [10.10.118.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9924860C04;
        Mon,  8 Feb 2021 18:13:02 +0000 (UTC)
Date:   Mon, 8 Feb 2021 12:12:59 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     AC <achirvasub@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, nborisov@suse.com,
        seth.forshee@canonical.com, yamada.masahiro@socionext.com
Subject: Re: [PATCH] x86/build: Disable CET instrumentation in the kernel for
 32-bit too
Message-ID: <20210208181259.hwmnoldx627jhvlm@treble>
References: <YCB4Sgk5g5B2Nu09@arch-chirva.localdomain>
 <YCCFGc97d2U5yUS7@arch-chirva.localdomain>
 <YCCIgMHkzh/xT4ex@arch-chirva.localdomain>
 <20210208121227.GD17908@zn.tnic>
 <82FA27E6-A46F-41E2-B7D3-2FEBEA8A4D70@gmail.com>
 <20210208162543.GH17908@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210208162543.GH17908@zn.tnic>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 08, 2021 at 05:25:43PM +0100, Borislav Petkov wrote:
> On Mon, Feb 08, 2021 at 10:19:33AM -0500, AC wrote:
> > That did fix it, thank you!
> 
> Thanks!
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Mon, 8 Feb 2021 16:43:30 +0100
> Subject: [PATCH] x86/build: Disable CET instrumentation in the kernel for 32-bit too
> 
> Commit
> 
>   20bf2b378729 ("x86/build: Disable CET instrumentation in the kernel")
> 
> disabled CET instrumentation which gets added by default by the Ubuntu
> gcc9 and 10 by default, but did that only for 64-bit builds. It would
> still fail when building a 32-bit target. So disable CET for all x86
> builds.
> 
> Fixes: 20bf2b378729 ("x86/build: Disable CET instrumentation in the kernel")
> Reported-by: AC <achirvasub@gmail.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Tested-by: AC <achirvasub@gmail.com>
> Link: https://lkml.kernel.org/r/YCCIgMHkzh/xT4ex@arch-chirva.localdomain

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh


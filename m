Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D163CC604
	for <lists+linux-arch@lfdr.de>; Sat, 17 Jul 2021 22:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbhGQUMl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Jul 2021 16:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbhGQUMk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Jul 2021 16:12:40 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3424C061762
        for <linux-arch@vger.kernel.org>; Sat, 17 Jul 2021 13:09:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l11so8859638pji.5
        for <linux-arch@vger.kernel.org>; Sat, 17 Jul 2021 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=82776rH7MVjULcdiuUyym0akABhJs4NldEt5laWMP9M=;
        b=RjlNuU2nRRKI/L7FvR9vpz5UTaWFd5anrqq/u7PC64CX+Tjt7PJrdNouY345NApcja
         eIODL3xOxUcwnySK7snZRMYVjRQGUGy/aEQVrRM9aepNxyBb+nNBKBiYsKivlzBddr0+
         UMjfxzS0n0rh/vIt0hufvnL1/fuDDm+ltKFoqLZaeY1qRZEIbqXnr9MdtSGQEBGNQoVA
         jFyjrsSwaZiiAIoV/qiUZIbfjBIQ0rWOI5yqfde6rfJWNp8DokJbl37N1zhLxd4RRw+a
         pSFFvvYobWkmoWE4RXwpHenD9RmAxLzZE+5qV6MCPXmRZQoyHCeuSnPnNgvf9xnZhVyR
         fRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=82776rH7MVjULcdiuUyym0akABhJs4NldEt5laWMP9M=;
        b=lXa0lJWwuA2iAZDuAsmfkPxwcSIdJi/0mUYeILR3H6ykUYfhmZlFV7YK3xcVglQmkM
         Y2dNjsuFEo8AVQjkhmwaX8WuhYxzWk3j+cmVlEVvxfpAU8FX4AVbipMnIimNOVa3ASp5
         Q/nxJF+8Ehxb1Cqa4+ZS5cKeymButVzHbJe6pHn6SaK9p3EOCmsIOhxrNmbf7ZAd+WT3
         o3+oo0dc7JtAb9LONRP7qR6YXXUEIR8bqvkwHc8D+srx3tO4WHK42pRB3WRJk6JJ1UHG
         O8IuockvE4WLW+ejYLFHXIDajGwCTjA7Amr4etLx10TroN1NPu1KzYI3rSepEtPdsC/y
         0/4Q==
X-Gm-Message-State: AOAM532ZK4Yom376VQ/jrn0B8xG/Qwg/puVF3v76emwSwCQtSsXUBj/5
        XcNilrutjLas4RgPKMao0Dg=
X-Google-Smtp-Source: ABdhPJySCboFhgLoxwLg4sjXQg4lrPMlfSj+GCPhKxXawXp2HW3MECdGoF9kCCyWph0kMPO56FlA9w==
X-Received: by 2002:a17:902:ec06:b029:12b:55c9:3b51 with SMTP id l6-20020a170902ec06b029012b55c93b51mr12473106pld.4.1626552583141;
        Sat, 17 Jul 2021 13:09:43 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-37-fibre.sparkbb.co.nz. [222.152.189.37])
        by smtp.gmail.com with ESMTPSA id e18sm14466388pfc.85.2021.07.17.13.09.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jul 2021 13:09:42 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
To:     "Eric W. Biederman" <ebiederm@xmission.com>
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
 <87zgunzovm.fsf@disp2133> <3b4f287b-7be2-0e7b-ae5a-6c11972601fb@gmail.com>
 <1b656c02-925c-c4ba-03d3-f56075cdfac5@gmail.com> <8735scvklk.fsf@disp2133>
Cc:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, torvalds@linux-foundation.org,
        schwab@linux-m68k.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
Date:   Sun, 18 Jul 2021 08:09:36 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <8735scvklk.fsf@disp2133>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Eric,

Am 18.07.2021 um 06:52 schrieb Eric W. Biederman:
>> I should have looked more closely at skeleton.S - most FPU exceptions
>> handled there call trap_c the same way as is done for generic traps,
>> i.e. SAVE_ALL_INT before, ret_from_exception after.
>>
>> Instead of adding code to entry.S, much better to add it in
>> skeleton.S. I'll try to come up with a way to test this code path
>> (calling fpsp040_die from the dz exception hander seems much the
>> easiest way) to make sure this doesn't have side effects.
>>
>> Does do_exit() ever return?
>
> No.  The function do_exit never returns.

Fine - nothing to worry about as regards restoring the stack pointer 
correctly then.

> If it is not too much difficulty I would be in favor of having the code
> do force_sigsegv(SIGSEGV), instead of calling do_exit directly.

That _would_ force a return, right? The exception handling in skeleton.S 
won't be set up for that.

> Looking at that code I have not been able to figure out the call paths
> that get into skeleton.S.  I am not certain saving all of the registers
> on an the exceptions that reach there make sense.  In practice I suspect

The registers are saved only so trap_c has a stack frame to work with. 
In that sense, adding a stack frame before calling fpsp040_die is no 
different.

> taking an exception is much more expensive than saving the registers so it
> might not make any difference.  But this definitely looks like code that
> is performance sensitive.

We're only planning to add a stack frame save before calling out of the 
user access exception handler, right? I doubt that will be called very 
often.

> My sense when I was reading through skeleton.S was just one or two
> registers were saved before the instruction emulation was called.

skeleton.S only contains the entry points for code to handle FPU 
exceptions, from what I've seen (plus the user space access code).

Wherever that exception handling requires calling into the C exception 
handler (trap_c), a stack frame is added.

Cheers,

	Michael

>

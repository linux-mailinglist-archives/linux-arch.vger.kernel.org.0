Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC24E3CCA83
	for <lists+linux-arch@lfdr.de>; Sun, 18 Jul 2021 21:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhGRTuZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Jul 2021 15:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhGRTuY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Jul 2021 15:50:24 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57A8C061762
        for <linux-arch@vger.kernel.org>; Sun, 18 Jul 2021 12:47:25 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d12so14422324pfj.2
        for <linux-arch@vger.kernel.org>; Sun, 18 Jul 2021 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sm9UXKWaOLmMdgyMPazNRI82mVI5gEErdQZuVKNglDA=;
        b=scrr6ospx/Cx4jnO+AtQts8mDAeJ75Mm9KbY0Ftc3QsibsTRNKTRgLKPcEzVdB7J+t
         eLmWjM7Jj8yEcNrnZsMotyerkIhJRg2jDOC5EvMdkzxHddLy7l4OjvAKKQGj8tczg6iR
         uXiKlo3woy3oQzj2mPXHC3LFns7/D2mh+nx2aiDvgdHYz05SDLrulxJksiHRuNtwJjBg
         F4XTJXpRBvne/XVs4fPvM9k3rkM63UzFwOHcgQZ1kPyu7EIZHG5IneeJeyV64FhKzkIL
         wMSHWrgLFVS066UAR23gf2CUk6aY6oIBR46+rvA5FAQ5DDRQ8InSwmbTvXsODC6rT5v2
         /M1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sm9UXKWaOLmMdgyMPazNRI82mVI5gEErdQZuVKNglDA=;
        b=Lu2F8qv7Lce+DVFCxPkxx6yj8aSDHzPkr4mPkBtJvIV7SaPa/YAZDD/s/2j0mt9mcE
         B4vVa8fzlrvoRVJD7QUVClBtLahlZl3HeUJIVYjlRROHZ6OsLnEhTWp0TfPMsuivTOt8
         98YfVNCKjLSgCTyV9DSguEGXI8I1WxGr2p28HB0MLNa1KzyKeh70xyao/ZHzKObJGIeF
         dra70jlbXFSgjgHbMdtNcAla31C1DcP/TdCvtCjhXcFz0iBScZ41QOF/BVhlMDCdUGB5
         6KtTt8Vw6MfyIin7kszCiX3HDquJFzSk9asCRSzG5oqenABnuAZnNBX61pFFHAjP1Xcc
         FlfQ==
X-Gm-Message-State: AOAM533MHixh0gNtxcbE0ZbSr7WR8IjJ9gnJ7ZcwtOT2GggEW3d8skVK
        ZDmdKLiYfq57xHH+delL5nk=
X-Google-Smtp-Source: ABdhPJwX/+vSGgzp5FnzD8Hb5DeH0gjbC5OeLzCVIYz0K1i0bzchyKVzwyfharMGyPe2NseBtpIaaA==
X-Received: by 2002:a63:ed12:: with SMTP id d18mr21134634pgi.12.1626637645267;
        Sun, 18 Jul 2021 12:47:25 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:c0c0:b5db:8872:c62b? ([2001:df0:0:200c:c0c0:b5db:8872:c62b])
        by smtp.gmail.com with ESMTPSA id o9sm17913235pfh.217.2021.07.18.12.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jul 2021 12:47:24 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, geert@linux-m68k.org,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        torvalds@linux-foundation.org
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
 <87zgunzovm.fsf@disp2133> <3b4f287b-7be2-0e7b-ae5a-6c11972601fb@gmail.com>
 <1b656c02-925c-c4ba-03d3-f56075cdfac5@gmail.com> <8735scvklk.fsf@disp2133>
 <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
 <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com> <87a6mj99vf.fsf@igel.home>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <1ebfb9de-de16-d05c-ea15-a110857fe284@gmail.com>
Date:   Mon, 19 Jul 2021 07:47:19 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87a6mj99vf.fsf@igel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andreas,

On 18/07/21 10:47 pm, Andreas Schwab wrote:
> On Jul 18 2021, Michael Schmitz wrote:
>
>> +	addql   #8,%sp
>> +	addql   #8,%sp
>> +	addql   #8,%sp
>> +	addql   #8,%sp
>> +	addql   #8,%sp
>> +	addql   #4,%sp
> aka     lea     44(%sp),%sp

Thanks - I knew there should be a better way.

Somewhere in entry.S is

addql   #8,%sp
addql   #4,%sp

- is that faster than

lea     12(%sp),%sp ?

Cheers,

	Michael


  


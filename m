Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901651D11B4
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 13:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgEMLq0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 07:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgEMLq0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 07:46:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB0AC061A0C;
        Wed, 13 May 2020 04:46:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n5so13223578wmd.0;
        Wed, 13 May 2020 04:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ARL8xyGIaHXk2o/Yx6BRPMsb1PUzwyBj6k1y6av6itM=;
        b=k+TdqyRgxoWkIW/nLDd9gMdzrW/XY00+H0ej5/9axyX5SHxJCJ7zz/G7aihleAv6Sj
         D8YRA5iMpWN5myZVktgDK+89dBIipQ/w03eq770K1TV7W5k0PLrdCoJ/PhewQXpk3wIB
         S9Kcdh15rqYlQ6EP1uJlhCbRsPihon2w7hPdu50kXd7TuMFzSU9cWDqfdhWP5GD5CIvs
         iYAdF+fBlAEQZKGOHNc3s3PZ18doU4p38k/ob2oAqhAkYY9qM33MJHmICex4m5ZunNTM
         nkrQmXFKyecXQzePJRJOekMhyQSi8trsjbMT9I2uh0lfuud1X85xQueyFFkf4pBjRCSh
         s+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ARL8xyGIaHXk2o/Yx6BRPMsb1PUzwyBj6k1y6av6itM=;
        b=fEJNfIyi93rkf3lZ3FhFTNrjoy+npwFjBXZBB9ljonxO4+O90iTnTREopkBPDOcmzi
         2dEIkFlE8ZB+PjwlMBTkGRS/WBrfEia60xP2lDt4jloqHOv/QKw69Z1cTlsyw3/8ckzi
         YZkzcqftYtdaI+PKgBBcwJOV+oTwMPfkIRUjoVTZBp6if5yMm1GzfwpVEpTW0lBIlVuN
         m8A7vg48AcFxj72DBIANwblldZWG68dnNzn7ynfmv3SDfk0sZvTVJUWQLubyzbA3Ra52
         Z8tMvM0vgW1US1YgC6ejgYfEnbsvaGqEKS40JtzGzcBeGqRec/aK3I59kPex9Klz9MQ/
         8YRA==
X-Gm-Message-State: AGi0Pub9waa6FDzcQCCyni2fI4nDM+LIH1LAaAdobCBpif0SbmTa2xUm
        z6Vp6bY26ZzgWAJUln0sV0c=
X-Google-Smtp-Source: APiQypLQuhIabEH8lIUINjIPJ1dcC6aBSIHkesphsAc552ZJMv8iBptiv4k4OVEfnTCCPj5qdevp+w==
X-Received: by 2002:a1c:990d:: with SMTP id b13mr41835949wme.179.1589370383490;
        Wed, 13 May 2020 04:46:23 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id v5sm26892576wrr.93.2020.05.13.04.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 04:46:23 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/14] prctl.2: ffix quotation mark tweaks
To:     Dave Martin <Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-7-git-send-email-Dave.Martin@arm.com>
 <7afe32a5-9675-74d4-7c39-f1271d475afd@gmail.com>
 <20200513113949.GI21779@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <f575e35d-cd5e-5808-bed4-91bdfb9c2905@gmail.com>
Date:   Wed, 13 May 2020 13:46:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513113949.GI21779@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/13/20 1:39 PM, Dave Martin wrote:
> On Wed, May 13, 2020 at 12:11:21PM +0200, Michael Kerrisk (man-pages) wrote:
>> Hello Dave,
>>
>> On 5/12/20 6:36 PM, Dave Martin wrote:
>>> Convert quote marks used for information terms in prose to use
>>> \(oq .. \(cq, for better graphical rendering.
>>>
>>> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>>
>> Again, this is a patch that I would prefer to see near the end 
>> of a series, rather than in the middle.
>>
>> I'm currently agnostic about this change. But, I do not
>> want to apply this patch, since no other pages in man-pages
>> use \(oq...\(cq.
>>
>> I haven't applied this patch. Luckily, that does not prevent
>> any of the later patches applying.
> 
> I'll be careful to move this sort of thing to the end of a series in
> future.
> 
> This was a provocative patch, so I'm happy for it to be dropped.
> 
> 
> The main motivation was that ' renders to PostScript etc. as a closing
> quote, which is fine for apostrophes but not fine for an opening quote
> mark.  Most of the current quotes in here are actually ", but I don't
> see an actual promise from groff that that renders as a neutral glyph
> either, so it seemed best to avoid.  For now " does seem to be rendered
> with a neutral glyph (i.e., neither opening or closing).

See my commit 11b0b31a14bd2c7dcb0cf7bc815b4c1887444a89, just pushed,
which addresses the ' issues.

>>> ---
>>>
>>> Note, this can lead to misrendering on badly-configured systems.
>>> However, many man pages do it.
>>
>> Can you say some more about this please?
> 
> Terminal character maps need to match LANG etc. in order for fancy
> characters coming out of nroff to display correctly.
> 
> ssh attempts to send LANG across, but terminal sessions between systems
> that have different locales installed can be a problem, as can dumb
> serial links that don't magically pass the locale and terminal type
> settings across.
> 
> The fact that I hit this problem a lot in some situations (particularly
> the serial link case) suggested to me that fancy characters are
> considered fine nowadays, but perhaps I'd need to dig into it some more
> to understand the situation fully.

Thanks for the clarification.

> (There are one or two ' that should really be \(aq anyway, but I'll
> try to address that separately.)

See above. I presume that patch is what you wanted?

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

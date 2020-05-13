Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1236D1D107F
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 13:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgEMLDd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 07:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbgEMLDa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 07:03:30 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA13CC061A0C;
        Wed, 13 May 2020 04:03:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j5so20363330wrq.2;
        Wed, 13 May 2020 04:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nh7DyJO+DcViOqeU3sNNSJYNP3Q1t6sUi1HzAPYYVu4=;
        b=XC7R3Z8D2P+2DjVhpBCDocDEHgLNV3dVkUCrmrki+JJqmjTbn/6Pz5XjCJYfmI9eDq
         n0hXdb5hqlm3kmJp8aL5CW2hBe28Ndr8jS5TAlMOc73gKJ61KGv6Tbmgy8hf7RCzj2tJ
         7CfJjPwYGl3jrTd/3h1lS2FDI+0dJr3DvcxiZz6idvQYQR5Lt6WbVOD8uag6anI7OqSh
         mVbIIa3ic/93ck98KrmshiOfl6uBhXSX+mRaev+DC+bRTZiqa9dwQVa5j+78gOXpx4hx
         m8NYDA8SKQJMyJkmqcuBpt/NAEmsgkEB0cn5naYstVDYLV5ZE99fPcPIM11I22e8F7Y0
         ju6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nh7DyJO+DcViOqeU3sNNSJYNP3Q1t6sUi1HzAPYYVu4=;
        b=XcSDs92PphF8DH7xJVGpew0m10utq8xZjm3Sqj9f1XbU3wKT06jglSGuOy4UtApiaJ
         WyeafTGNbWzbPVOc9JhenHpJCWgI17pg8jYDxMkdAH/5AWgEEovoVnujJjGiH2OItNaJ
         lzuyrZ9F7d4yHiKDlcYsrDsTAbs5W3wTtmzWZ3AC8AUeQSK+hokeHJQXz8OnNih3t9OT
         Q48UjbmT9dijbbRtIiO0mlOtDZ5plPyRc4cviamAycKj3Drfx0isvdFxg6Gzxgs1aWpk
         E59hChbBNZEVnjzVbfrd3m/NkTJtAI31Pz8nF9hUyOqw+EFB+qUSa5y6lJ3iYeIXSgBR
         i3Xw==
X-Gm-Message-State: AGi0PuZ9NaESTEXJqOt3Tq/4TvYqWhQH4WUzxngKIfP8hiZM8p2ia/Bv
        JmjQ3nAgesK9tgjgFCReBTM=
X-Google-Smtp-Source: APiQypLtpJHo8ffwbbRkV/avsRbKUL1xHjzoj2MxEP2X+KQPOSe2utWuS8fB9xpuBPcH+EAxWl8lEw==
X-Received: by 2002:adf:a74b:: with SMTP id e11mr28414461wrd.99.1589367808517;
        Wed, 13 May 2020 04:03:28 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id s2sm4208877wme.33.2020.05.13.04.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 04:03:28 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/14] prctl.2: srcfix add comments for navigation
To:     Dave Martin <Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-5-git-send-email-Dave.Martin@arm.com>
 <8b882b6e-376b-111d-3c3c-7a042b0e91b5@gmail.com>
 <20200513105620.GE21779@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <9770249d-0d5a-1b02-4de1-bbb6343b5829@gmail.com>
Date:   Wed, 13 May 2020 13:03:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513105620.GE21779@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave,

On 5/13/20 12:56 PM, Dave Martin wrote:
> On Wed, May 13, 2020 at 12:09:27PM +0200, Michael Kerrisk (man-pages) wrote:
>> Hi Dave,
>>
>> On 5/12/20 6:36 PM, Dave Martin wrote:
>>> The prctl.2 source is unnecessarily hard to navigate, not least
>>> because prctl option flags are traditionally named PR_* and so look
>>> just like prctl names.
>>>
>>> For each actual prctl, add a comment of the form
>>>
>>> 	.\" prctl PR_FOO
>>>
>>> to make it move obvious where each top-level prctl starts.
>>>
>>> Of course, we could add some clever macros, but let's not confuse
>>> dumb parsers.
>>
>> A patch like this, which makes sweeping changes across the page,
>> should be best placed at the end of a series, I think.
>> The reason is that if I fail to apply this patch (and I am a
>> little dubious about it), then probably the rest of the patches
>> in the series won't apply. (Furthermore, it also forced me to
>> apply patch 02 already, which I wanted to reflect on a little.)
> 
> Agreed, I'll try to do that in future.
> 
>> That said, I'll apply it, so that the remaining patches
>> apply cleanly. I'll consider later whether to keep this
>> change. For example, I wonder if a visually distinctive 
>> source line that is always the same would be better than
>> these comments that repeat the PR_* names. For example, 
>> something like
>>
>> .\" ==========================
>>
>> I'll circle back to this later.
> 
> I'd prefer to keep the name if we can, since navigating by search is
> otherwise bothersome due to false hits.
> 
> Could we do both, say:
> 
> .\" === PR_FOO ===

Okay -- I'll give that some thought.

> If you prefer to reject this patch, I'm happy to rebase and repost the
> series as appropriate.
> 
> In any case, this one is nice to have rather than essential.

For now, the patch is already committed and pushed.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

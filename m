Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B671D11BC
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 13:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgEMLsj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 07:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgEMLsj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 07:48:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA9C061A0C;
        Wed, 13 May 2020 04:48:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so28113248wmc.5;
        Wed, 13 May 2020 04:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QVYIjnNVmi9zPZuwG6rsdSUCwiZb6REzOrsdfVzUiHw=;
        b=nlyeJmzBlL//a3eDINJ+hj3Nog0mKfTkxziV9cdUM7mTlfuP3HEJ4fJiAM1t3jsed8
         ROfDfuzcI5wWbEucUavHVkZgBy3yde7QKeqbMj0XMb8Ubhh2Lxp8nFF+3jqRvbjGdQvF
         vMDvt3av3+mTyX4Qaz33vmnxtFwOTR9QEWBpqHW9nuYzq/uFyL8zBtvqIY2e9ta1Ebtd
         jnRWNDRNeMBROsLeN42B8gRvmTOJWsifyan5/m14+hB7RJFmmv0F+TvtISU8yhsCcbR1
         3B+hE09m+d4HVTHPHbUZp+L1miJv4ux1IE+ah/aGsgFuqXU4LQVIbsQNuwQ4h/R3m4MG
         78wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QVYIjnNVmi9zPZuwG6rsdSUCwiZb6REzOrsdfVzUiHw=;
        b=I/J2pHqgaDjMvtsJevMH12n56pyqOwaHIEmLSbR6U6bIfDIdwaIz2tRFACbq1tJ+tP
         upJdAqTdtTJ44bBHYVVk3KDqhjv/J+r8UpwT8pR83r+GVDn5+CrE2vnvkcNUBRUE0rxv
         JhtubC1l9fqCoP5fcMIpDAfN4Uf2vvmQdFXJlc+WdcYothZ0QWMiMKLb+rNH3peFyQoS
         nmMvfqDl1lEbXQ7VcG8XspDAFCqiGPib+j2ihOXg3aGVnoCxV5H5RCbs5plTJrqPLonJ
         nwSDHRbbqLKxY3MlIrspOD+mbMmf4eF90QgdsIxZTXpLjgOdZx8volkyX8+LnGZG5eOa
         Q6QA==
X-Gm-Message-State: AGi0PuZ2CoVFJqPJCOMP+c8c1pUsjXZLw87VacmC6VsP/IAl8Edy4bt2
        rL1mV8DxPOo1NXG0iShpoCk=
X-Google-Smtp-Source: APiQypJd0LcYv5I01IBUf5v6/5hJSjufh16rTh3JyT2BlAXn4Cfuyn3Zhnpw085vM50ZFoXnJ/pB3Q==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr11130120wmh.87.1589370517642;
        Wed, 13 May 2020 04:48:37 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id w15sm26026533wrl.73.2020.05.13.04.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 04:48:37 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/14] prctl.2: srcfix add comments for navigation
To:     Dave Martin <Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-5-git-send-email-Dave.Martin@arm.com>
 <8b882b6e-376b-111d-3c3c-7a042b0e91b5@gmail.com>
 <20200513105620.GE21779@arm.com>
 <9770249d-0d5a-1b02-4de1-bbb6343b5829@gmail.com>
 <20200513111557.GG21779@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <022b1d7f-8381-a9a8-b5aa-907143fd4831@gmail.com>
Date:   Wed, 13 May 2020 13:48:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513111557.GG21779@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave,

On 5/13/20 1:15 PM, Dave Martin wrote:
> On Wed, May 13, 2020 at 01:03:27PM +0200, Michael Kerrisk (man-pages) wrote:
>> Hi Dave,
>>
>> On 5/13/20 12:56 PM, Dave Martin wrote:
>>> On Wed, May 13, 2020 at 12:09:27PM +0200, Michael Kerrisk (man-pages) wrote:
>>>> Hi Dave,
>>>>
>>>> On 5/12/20 6:36 PM, Dave Martin wrote:
>>>>> The prctl.2 source is unnecessarily hard to navigate, not least
>>>>> because prctl option flags are traditionally named PR_* and so look
>>>>> just like prctl names.
>>>>>
>>>>> For each actual prctl, add a comment of the form
>>>>>
>>>>> 	.\" prctl PR_FOO
>>>>>
>>>>> to make it move obvious where each top-level prctl starts.
>>>>>
>>>>> Of course, we could add some clever macros, but let's not confuse
>>>>> dumb parsers.
>>>>
>>>> A patch like this, which makes sweeping changes across the page,
>>>> should be best placed at the end of a series, I think.
>>>> The reason is that if I fail to apply this patch (and I am a
>>>> little dubious about it), then probably the rest of the patches
>>>> in the series won't apply. (Furthermore, it also forced me to
>>>> apply patch 02 already, which I wanted to reflect on a little.)
>>>
>>> Agreed, I'll try to do that in future.
>>>
>>>> That said, I'll apply it, so that the remaining patches
>>>> apply cleanly. I'll consider later whether to keep this
>>>> change. For example, I wonder if a visually distinctive 
>>>> source line that is always the same would be better than
>>>> these comments that repeat the PR_* names. For example, 
>>>> something like
>>>>
>>>> .\" ==========================
>>>>
>>>> I'll circle back to this later.
>>>
>>> I'd prefer to keep the name if we can, since navigating by search is
>>> otherwise bothersome due to false hits.
>>>
>>> Could we do both, say:
>>>
>>> .\" === PR_FOO ===
>>
>> Okay -- I'll give that some thought.
>>
>>> If you prefer to reject this patch, I'm happy to rebase and repost the
>>> series as appropriate.
>>>
>>> In any case, this one is nice to have rather than essential.
>>
>> For now, the patch is already committed and pushed.
> 
> OK, thanks.  I'm happy to write a further patch when you've decided what
> to do, if it saves you work.

Let's leave this for the moment. Once the dust settles on your 
remaining patches, I'll try to remember to circle back on this.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

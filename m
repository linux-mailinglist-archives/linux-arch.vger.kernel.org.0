Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACDD1F38E6
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jun 2020 13:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgFILAV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Jun 2020 07:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbgFILAT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2020 07:00:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1614DC03E97C;
        Tue,  9 Jun 2020 04:00:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d128so2667830wmc.1;
        Tue, 09 Jun 2020 04:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=um+9GThB8p8rNN6JgnNnOtUG9o2dEln+9lSb83i4/9A=;
        b=epScxDKhKl3E7HP4w0yQGMeXUqGyQ4E8j/F6gngzDZruAoirtC2Fjca/nVZk0Rj5ew
         4jE3l5GRc5LTEHmZd7Frei/D6hv5YpJr1KYbiAXZm8BUPyshiquwaK+8QgOivmw/uoID
         ocSFK+bHrvUmDd5M3bmYoJdhJRmFmHTzEutDoSqpCq3ahzKlTKTxFg5ckxJGcyFD2jku
         NKa1l8y1O8FvpqHfA42cCL2BQ39oFYND3E1JbxL8CYOaKoFivETwvlrZRH6nWo8txBbs
         MVXSSUAsSCV8/w9u7LTgV3uQa+p3iuphEIv+QyDHA4UOzZAx/mnd5+xMUrhHH2oRnqqA
         9/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=um+9GThB8p8rNN6JgnNnOtUG9o2dEln+9lSb83i4/9A=;
        b=SHv4mV3h4i71Fv95GsnQSxcAfi8UWmX50euD7zqmQpw5ibV6coRhZQmV4mLd5mM3MJ
         qtnpPQ3nRi6ImFTX3bIRyqBy0CvDjssxQLeD1BKN+kIk6eFaJw6C3Py76rv4BeCPv/bF
         GZOSBwLSc/YS2fxB3+8hFdmQZSBbOYAuyEyiPeGIAZPDfwMc/9ywQlbR3owfVbhizSRh
         2udptqrMAILCFEyHzvGVGx+1hd81iQMyEBjqYkV/MYIhglGg1RLv2I1hf69fKhmW7js0
         sLzuVz/gvqRgure70obPphTqU6IfqiK0/NE5uc2yDGs6bK8R8yXB3NEZ319xsCeHQNhy
         veug==
X-Gm-Message-State: AOAM530V/FZRLlYPllT1zOHMLfT1NDzcYRJoF1kmVz3Ikb/U0rGwFULj
        sipZN0tdH6HeyumtpDamido=
X-Google-Smtp-Source: ABdhPJwD0bvU+Di0C188WUrbdjPCTsD4EB5VTQYlPCEw8eTROa4hG09PWBQfXyS7zz9t16DWQ62cKQ==
X-Received: by 2002:a1c:4b18:: with SMTP id y24mr3551231wma.102.1591700416622;
        Tue, 09 Jun 2020 04:00:16 -0700 (PDT)
Received: from ?IPv6:2001:a61:253c:8201:b2fb:3ef8:ca:1604? ([2001:a61:253c:8201:b2fb:3ef8:ca:1604])
        by smtp.gmail.com with ESMTPSA id u130sm2551644wmg.32.2020.06.09.04.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 04:00:16 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man <linux-man@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/6] prctl.2: Add PR_SPEC_INDIRECT_BRANCH for
 SPECULATION_CTRL prctls
To:     Dave Martin <Dave.Martin@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-3-git-send-email-Dave.Martin@arm.com>
 <CAKgNAkhwYASEM+wqaDZQ-ftcB3jnsVN2cXq4E_1ep1rqv+4aLw@mail.gmail.com>
 <20200601135112.GB5031@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <61446b0d-5c17-2cb7-79a6-770c931c4b2a@gmail.com>
Date:   Tue, 9 Jun 2020 13:00:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601135112.GB5031@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/1/20 3:51 PM, Dave Martin wrote:
> On Thu, May 28, 2020 at 09:01:59AM +0200, Michael Kerrisk (man-pages) wrote:
>> Hi Dave,
>>
>> On Wed, 27 May 2020 at 23:18, Dave Martin <Dave.Martin@arm.com> wrote:
>>>
>>> Add the PR_SPEC_INDIRECT_BRANCH "misfeature" added in Linux 4.20
>>> for PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.
>>>
>>> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>
>> I had also applied this patch from the email you sent earlier. I've
>> pushed those changes to master now.
> 
> Thanks for this.
> 
> Do you publish a "development" branch somewhere, or similar?

Ocassionally, I do this on a per-series basis.

> 
> If possible, it's nice to have git rebase work out which patches to drop
> for me rather than me doing it by hand.

Yuh, sorry about that. I'l try to do it bette rnext time.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

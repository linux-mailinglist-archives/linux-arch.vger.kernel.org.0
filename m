Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D00028E1FA
	for <lists+linux-arch@lfdr.de>; Wed, 14 Oct 2020 16:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgJNOOI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 10:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgJNOOI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2020 10:14:08 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DEAC061755;
        Wed, 14 Oct 2020 07:14:08 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id j8so1820254pjy.5;
        Wed, 14 Oct 2020 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=69069AnehaVf3UnSZwNG1/x2dVHK2fJGYXosNGLirqA=;
        b=tPQ9t0LVAjdXlrRg8FlQwBDOUkZpALEmpbMxXBjfr5wAr9LYMa9Uam1636/b8zhDXL
         8b1l5zaeo7D5wrgmZUQBpBJFiV1zb/c6F02lPDDFml5Dedkp0chOBTDBRFBoRJQLGsFN
         1/1lnzG40gcoB8upIsgAl65cpOEo2zUTMrqIoZnu4rSiQAOnn6KRbXRHJgWHERRNEoGQ
         TqGFhtyUUiA4/2wqM8E14cI6UNIXLO1W1dbP23Zekc5G2QpwU7nG3Ii/Y/ZFiZIH+NW3
         wVQgVoLyawsOsEKwYjIzXsXzFkE8m/3KdobzUvlWHCcobHVrOIygQhoLX/AUWn6vy1mN
         co8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=69069AnehaVf3UnSZwNG1/x2dVHK2fJGYXosNGLirqA=;
        b=r1Oqi8vM7kwb9vGd5ZEfyQZGw3cFw1KtNi8lzjoICKezEEMXXIvKlDaXBQinzEq+YU
         O9GQvJ+zTeJsywq1s/b5KP/s1i1PcrZaCN4psACaL+X8L4JtmG3AgD+7pAasWe7oZTVW
         WUeHQJiJ+THc6zxIbJQu0sj5ashOoDssxe1qIBfgld2nZEor9UQAKA6DZAfMmoyzakH0
         Bq0/yTr7nWsZczZJOihEUTex7bSZKqH5YTn1yo7jiE7Ea/K+agTP0krHEf7A5UFV3m99
         YJSlBeeojOdh4Ac7GeYrLUDX8RzRecwOBhIhhDo5urEucE8/8Y2ipHH00Uuq4sntxxVk
         /Gig==
X-Gm-Message-State: AOAM531fxD90Vp+h7o2In9Wj/kfS9HomnDUMJIbr9scGg8pWeb3V2LZg
        x1DBuJAMTYpzlmbEYoOfG7w=
X-Google-Smtp-Source: ABdhPJwlSk9NJC9q/BbL/TeawLocBTV2wGEM3Q5doa1fGqW4pcUFHwvWxzrPHTj759w63AA03MH2Qw==
X-Received: by 2002:a17:90a:ca95:: with SMTP id y21mr3724437pjt.68.1602684847425;
        Wed, 14 Oct 2020 07:14:07 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id m13sm3695976pfd.65.2020.10.14.07.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 07:14:06 -0700 (PDT)
Subject: Re: [PATCH v2 02/24] tools: docs: memory-model: fix references for
 some files
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
 <44baab3643aeefdb68f1682d89672fad44aa2c67.1602590106.git.mchehab+huawei@kernel.org>
 <20201013163354.GO3249@paulmck-ThinkPad-P72>
 <20201013163836.GC670875@rowland.harvard.edu>
 <20201014015840.GR3249@paulmck-ThinkPad-P72>
 <20201014095603.0d899da7@coco.lan>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <aaeeba66-48be-0354-8f1c-261b361ae17f@gmail.com>
Date:   Wed, 14 Oct 2020 23:14:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014095603.0d899da7@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 14 Oct 2020 09:56:03 +0200, Mauro Carvalho Chehab wrote:
> Em Tue, 13 Oct 2020 18:58:40 -0700
> "Paul E. McKenney" <paulmck@kernel.org> escreveu:
> 
>> On Tue, Oct 13, 2020 at 12:38:36PM -0400, Alan Stern wrote:
>>> On Tue, Oct 13, 2020 at 09:33:54AM -0700, Paul E. McKenney wrote:  
>>>> On Tue, Oct 13, 2020 at 02:14:29PM +0200, Mauro Carvalho Chehab wrote:  
>>>>> - The sysfs.txt file was converted to ReST and renamed;
>>>>> - The control-dependencies.txt is not at
>>>>>   Documentation/control-dependencies.txt. As it is at the
>>>>>   same dir as the README file, which mentions it, just
>>>>>   remove Documentation/.
>>>>>
>>>>> With that, ./scripts/documentation-file-ref-check script
>>>>> is now happy again for files under tools/.
>>>>>
>>>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
>>>>
>>>> Queued for review and testing, likely target v5.11.  
>>>
>>> Instead of changing the path in the README reference, shouldn't 
>>> tools/memory-model/control-dependencies.txt be moved to its proper 
>>> position in .../Documentation?  
>>
>> You are of course quite right.  My thought is to let Mauro go ahead,
>> given his short deadline.  We can then make this "git mv" change once
>> v5.10-rc1 comes out, given that it should have Mauro's patches.  I have
>> added a reminder to my calendar.
> 
> Sounds like a plan to me.
> 
> 
> If it helps on 5.11 plans, converting this file to ReST format is quite
> trivial: it just needs to use "::" for C/asm code literal blocks, and 
> to replace "(*) " by something that matches ReST syntax for lists,
> like "(#) " or just "* ":
> 
> 	https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#bullet-lists
> 
> See enclosed.

I'm afraid conversion of LKMM documents to ReST is unlikely to happen
any time soon.
It should wait until such time comes when the auto markup tools become
clever enough and .rst files looks exactly the same as plain .txt files.

Am I asking too much? :-)

        Thanks, Akira

> 
> Thanks,
> Mauro
> 
> [PATCH] convert control-dependencies.rst to ReST
> 

[snip]

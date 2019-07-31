Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADA67C632
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2019 17:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfGaPTg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Jul 2019 11:19:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41902 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729559AbfGaPTg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Jul 2019 11:19:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so30515867pls.8;
        Wed, 31 Jul 2019 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W/U4EJuJSGtAQh18cTCHJ6wb0QAX2d/3mMx3nnicC/Q=;
        b=UXEn/5Jx1+r0zOczfz5iaXt/veIp+L1moBxgVDpP9pIF+LUG8PqVSIJY4bAMnanVF+
         oyEhkuYHzvHYqO2vGtHfekZWuv7qWEw5pswUPwHliQIFVAEV7vppPkNEhEaVbL5O1kWn
         e9ugWQOkNMaOi4/AgVO6K8P01zOqFcG5ylXyj0jp/awOvZeeMmKxNt/LxfWxG+wuErPM
         GPecH94fzG5v+b6mmP+eBPJ28ZcKztPBkn018lqIKFAHqBkfeOGl14TIKBUzjm688fju
         /bN6d/aNLPLeEW1c50Av01Gc1Ke+u+Y5fFmMjSsHlIowL0fuor+HyPiun49Rj8ei26LE
         ysfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W/U4EJuJSGtAQh18cTCHJ6wb0QAX2d/3mMx3nnicC/Q=;
        b=Mj40N0boq5eDM33X91h2Ikb03FDSagaGj7ylc6CxIdIR6xkCPNcbAXd9poWqoAONrg
         RXAV78nRIQoR5GDK7S0w/iKiwp0XxxKjnbh0Ypd9m96adIo9nMdx0c5iVqKfpdfvdjYU
         vp6FtV5qwCgzelWPcT7dnc5olnEoctTC3aoKebkcIqj925qCk7CF6voaN/dXb6zOGp0V
         ubTq0mTZz9i8VD+ZZFI6pisRjJRloZavDjnmchusD4nMCIjHmFzSxMc0nJwK7dzkc9IN
         HNe38GymOJOP2G/goYQ7Z7hEPMiQqCSgvTAXabxMQh4JaRZC3fGLjEkgpxk6X8SAT0S7
         p+vg==
X-Gm-Message-State: APjAAAUUoCxxgRdT+yWA4OCzfNO/99FONZEHMlZkfD5lFj47cfIUdUqC
        fMie7HpkN3a/D8ciiahIGx8+MOLp
X-Google-Smtp-Source: APXvYqzmDgfyB8QmV/vQxBch9AbAOB/lAUUL209PSPSOWOse7jwfuYVSmgKg0FDDp5VAtOIdTBf3Dw==
X-Received: by 2002:a17:902:b713:: with SMTP id d19mr122222858pls.267.1564586375246;
        Wed, 31 Jul 2019 08:19:35 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id o129sm44714617pfg.1.2019.07.31.08.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:19:34 -0700 (PDT)
Subject: Re: [PATCH] tools: memory-model: add it to the Documentation body
To:     Alan Stern <stern@rowland.harvard.edu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        SeongJae Park <sj38.park@gmail.com>, linux-arch@vger.kernel.org
References: <Pine.LNX.4.44L0.1907310947340.1497-100000@iolanthe.rowland.org>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <cb9785b7-ed43-b91a-7392-e50216bd5771@gmail.com>
Date:   Thu, 1 Aug 2019 00:19:25 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1907310947340.1497-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 31 Jul 2019 09:52:05 -0400, Alan Stern wrote:
> On Tue, 30 Jul 2019, Mauro Carvalho Chehab wrote:
> 
>> Em Tue, 30 Jul 2019 18:17:01 -0400
>> Joel Fernandes <joel@joelfernandes.org> escreveu:
> 
>>>>> (4) I would argue that every occurence of
>>>>> A ->(some dependency) B should be replaced with fixed size font in the HTML
>>>>> results.  
>>>>
>>>> Just place those with ``A -> (some dependency)``. This will make them use
>>>> a fixed size font.  
>>>
>>> Ok, understood all these. I guess my point was all of these will need to be
>>> done to make this document useful from a ReST conversion standpoint. Until
>>> then it is probably just better off being plain text - since there are so
>>> many of those ``A -> (dep) B`` things.
> 
>> On a very quick look, it seems that, if we replace:
>>
>> 	(\S+\s->\S*\s\w+)
>>
>> by:
>> 	``\1``
>>
>>
>> On an editor that would allow to manually replace the regex (like kate),
>> most of those can be get.
>>
>> See patch enclosed.
> 
> Some time ago I considered the problem of converting this file to ReST 
> format.  But I gave up on the idea, because the necessary changes were 
> so widespread and the resulting text file would not be easily readable.
> 
> Replacing things of the form "A ->dep B" just scratches the surface.  
> That document teems with variable names, formulas, code extracts, and
> other things which would all need to be rendered in a different font
> style.  The density of the markup required to do this would be
> phenomenally high.
> 
> In my opinion it simply was not worthwhile.

+1 on keeping this and the other .txt files of LKMM intact.

        Thanks, Akira

> 
> Alan Stern
> 


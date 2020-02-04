Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E441522F2
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 00:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgBDXRP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Feb 2020 18:17:15 -0500
Received: from mail-yw1-f49.google.com ([209.85.161.49]:40534 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgBDXRP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2020 18:17:15 -0500
Received: by mail-yw1-f49.google.com with SMTP id i126so594797ywe.7;
        Tue, 04 Feb 2020 15:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YdkJ2HHqkFeV4MfBlikH3/s69MOb8K9EarZU9wY8Wfo=;
        b=GgU6iCvG42Zqnm59Ohy4IAYVurS/XyB11MQ7DZ5ABPgTHF/mRAAlXksAMQPXiptV5Z
         M+TyJvm0YNYFEtpYN1JyRmRobbIlvNOB6Q2hKnJCx8Jc6RQS9mceFuyj88XzV8w2eLYw
         XS2170EWXX9NHuVWUPGt3Rw5eZGYjLhscAM7ctNuyrygyqMBq9WQwOF6XViU3sCql/Tm
         ouRXrVlhOhaQTgmmILkApEOZmx4OebkacXZzk7A4IkyCSjSl1B1jSMO2SjWoSuPNHq2h
         68YCUBmZo0eYkJE6GmWStK4vAtFq/2DkkAXQllhtIBNw4KwS8fo+Ic/WZ32x3tyBRnEm
         Oihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YdkJ2HHqkFeV4MfBlikH3/s69MOb8K9EarZU9wY8Wfo=;
        b=nibJq56vkn2beU+HK88S5Pe46sBmhUbN8Sh5/gRXiUdkF8j4VuWHtS70WhO6PrVRL+
         9o2e3WYie/jFgv+wqOEKo/eTic+DQM7S2GzGTosYSKqkA/knCtwsYI9bq7Ma/Mhyi/qu
         MT92ysimDEhllmRU/pKXmJWtPZswhQ3U8g8rcZfrQ6PDOemfSeUzYT/S7lqH18eY5G6M
         fnsARFehSVgis1LwFbsIo35IlgcPnh3oY8AMKJoAMCM11A4GlC5AooYuMrSvKvx8VLKb
         7q5adsmXTxDhc4clLNV/IpSxls7Z7h1hgIO2GScXeTLAhl28mt89CgIu6CXXFto4/Vos
         r26g==
X-Gm-Message-State: APjAAAUmh4JwVoQWQNRtkldh2dHLDh9pCxmml+88WybHTDxvF8wn9pR/
        kCRmgkS3B96jtMweVSD3G6k=
X-Google-Smtp-Source: APXvYqwT9wwXLR/3DoaUcImGoKvAUaPC2hvqP+ba1hWptBKiDXitI2/2JMF0e416IAJbgP6bR07QSA==
X-Received: by 2002:a05:6902:725:: with SMTP id l5mr19608845ybt.91.1580858233993;
        Tue, 04 Feb 2020 15:17:13 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id w128sm10582615ywf.72.2020.02.04.15.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2020 15:17:13 -0800 (PST)
Subject: Re: [PATCH v2 2/7] arch: um: add linker section for KUnit test suites
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Knut Omang <knut.omang@oracle.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200130230812.142642-3-brendanhiggins@google.com>
 <e060bdfc-5cdb-fb62-48b0-cc54c7bc72ce@gmail.com>
 <CAFd5g46irbQ7j_DOY+bQPoo1TWjwvu6n9iyQ7abe9pfqydeMYg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <1da1538d-2e4c-0ed0-5fae-6f9033230c46@gmail.com>
Date:   Tue, 4 Feb 2020 17:17:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g46irbQ7j_DOY+bQPoo1TWjwvu6n9iyQ7abe9pfqydeMYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/4/20 4:30 PM, Brendan Higgins wrote:
> On Tue, Feb 4, 2020 at 1:59 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 1/30/20 5:08 PM, Brendan Higgins wrote:
>>> Add a linker section to UML where KUnit can put references to its test
>>> suites. This patch is an early step in transitioning to dispatching all
>>> KUnit tests from a centralized executor rather than having each as its
>>> own separate late_initcall.
>>
>> All architectures please.
> 
> I *am* supporting all architectures with this patchset.
> 
> The first patch in this series adds support to all architectures
> except UML (admittedly I only tried x86 and ARM, 32 bit and 64 bit for

Right you are.  My mind did not span from patch 1 to patch 2. Apologies for
the noise.


> both, but I am pretty sure someone tried it for POWER and something
> else, so maybe I should try it with others before submission). A patch
> specific for UML, this patch, was needed because UML is a special
> snowflake and has a bunch of special linker scripts that don't make
> the change in vmlinux.lds.h (the previous patch) sufficient.
> 
>> The early versions of Kunit documented reliance on UML.  Discussion lead to
>> the conclusion that real architectures and real hardware would be supported.
> 
> I am *very* aware.
> 
> I would never intentionally break support for other architectures. I
> know it is very important to you, Alan, and others.
> 
>> This like this are what make me reluctant to move devicetree unittests to
>> KUnit.
> 
> Hopefully I can reassure you then:
> 
> With Alan as a regular contributor who cares very much about non-UML
> architectures, it would be very unlikely for me to accidentally break
> support for other architectures without us finding out before a
> release.
> 
> I also periodically test KUnit on linux-next on x86-64. I have gotten
> bugs for other architectures from Arnd Bergmann and one of the m86k
> maintainers who seems to play around with it as well.
> 
> So yeah, other people care about this too, and I would really not want
> to make any of them unhappy.

Thanks for the extra reassurance.


> 
>> Can you please add a section to the KUnit documentation that lists things
>> like the expectations, requirements, limitations, etc for a test case that
>> is run by KUnit?  Some examples that pop to mind from recent discussions
>> and my own experiences:
>>
>>   - Each test case is invoked after late_init is complete.
>>       + Exception: the possible value of being able to run a unit test
>>         at a specific runlevel has been expressed.  If an actual unit
>>         test can be shown to require running earlier, this restriction
>>         will be re-visited.
>>
>>   - Each test case must be idempotent.  Each test case may be called
>>     multiple times, and must generate the same result each time it
>>     is called.
>>       + Exception 1: a test case can be declared to not be idempotent
>>         [[ mechanism TBD ]], in which case KUnit will not call the
>>         test case a second time without the kernel rebooting.
>>       + Exception 2: hardware may not be deterministic, so a test that
>>         always passes or fails when run under UML may not always to
>>         so on real hardware.  <--- sentence copied from
>>         Documentation/dev-tools/kunit/usage.rst
>>           [[ This item and 1st exception do not exist yet, but will exist
>>           in some form if the proposed proc filesystem interface is
>>           added. ]]
>>
>>   - KUnit provides a helpful wrapper to simplify building a UML kernel
>>     containing the KUnit test cases, booting the UML kernel, and
>>     formatting the output from the test cases.  This wrapper MUST NOT
>>     be required to run the test cases or to determine a test result.
>>     The formatting may provide additional analysis and improve
>>     readability of a test result.
>>
>>   - .... There is more that belongs here, but I'm getting side tracked
>>     here, when I'm trying to instead convert devicetree unittests to
>>     KUnit and want to get back to that.
> 
> Sure, I think that's a great start! Thanks for that. I hope you don't
> mind if I copy and paste some of it.

Please do.  And no need to credit me.


> It kind of sounds like you are talking about more of a requirements
> doc than the design doc I was imagining in my reply to you on the
> cover letter, which is fine. The documentation is primarily for people
> other than me, so whatever you and others think is useful, I will do.
> 

I wasn't really sure what to label it as.  My inspiration was based
a little bit on reading through the Linux 5.5 KUnit source and
documentation, and trying to understand the expectations of the
KUnit framework and what the test cases have to either obey or
can expect.

I think there is a lot of history that you know, but is only visible
to test implementors if they read through the past couple of years
email threads.

-Frank

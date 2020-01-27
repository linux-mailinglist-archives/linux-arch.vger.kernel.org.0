Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3999A14A928
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2020 18:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgA0RkJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jan 2020 12:40:09 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35965 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgA0RkJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jan 2020 12:40:09 -0500
Received: by mail-yb1-f194.google.com with SMTP id w9so5322147ybs.3;
        Mon, 27 Jan 2020 09:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j9dC9atddjwhmNiTvc6WPJRfCurkBqs6BV53aCM4Bwc=;
        b=OrtXl6vij+Mbbk4wgtpwcJXca/uvZU7TKn+2pkoyMcKjgxpuh2k1xmdOgMDcDz6Xzn
         r5+GCjwi0ZAcryu0kzX/sXeiysftIbg+7bO25SXytmKDYr+YC7Sp5CD/dZdCGTcIVzM9
         8w5+OYfBgXbuhvP4tkeZZ1AAWStIu4kMlJc61MsCDGoX6zALzdZvK+dxVCuxbFl3N/o8
         7efinvTJn+63gLV07aybHUXkRVdVEyTMuGHEhNPASKHMJEQnqRIUY1Cx8QWLOj6qvQRi
         ozEuuFUkidSXE4/1QLJiDTjg48GhIvC1brJO18GLHSFi9pzZ3aNxoVm9oTAzAbz/Hf44
         sGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j9dC9atddjwhmNiTvc6WPJRfCurkBqs6BV53aCM4Bwc=;
        b=OprO+3Qy8Mco+NS0IrgOI+G5oIyZRJBXBAYkMWpsvKUnuXuBmamg/0TshEecWdKYta
         psul44/mFfQ4Gz0aiqFHws5o3DghL4cS/V6hXr5dIQ+09qGvtkKU5PYUGb9XfwHxJoJh
         +YU5nXnxryM+UrAG70g/LKBfqnSZP9SDTrG4YNOUPk2gCw+kC7wkMLz/Pgc6tH2lncxm
         +phYDCGWow4/yLeQjfsfUP9s9STpH2+jKwC1MSXopxUvTHPziXrNURmCv4lsImNSjwwX
         Jtrvfy+BUqiqJmVfgBMwhw5IutgddnrZCp7xpwr4ikEemEaCVT3yHglmorBLGifEAE7l
         pZ6A==
X-Gm-Message-State: APjAAAUWLtzKGBcofrvvKtl5ReEVdPLTOfFp+Z8xxnnK1q/Xg53oMY5o
        oYuZ8P3G1MTgYVuVDwZ1XVg=
X-Google-Smtp-Source: APXvYqy9464eXN+V1ydj3j8IcHLXt6BT+/2InNbiB1P1ib719zO2q2+7fx+heaO7zSVOWbuO4nBJnA==
X-Received: by 2002:a25:cec6:: with SMTP id x189mr12435848ybe.64.1580146807848;
        Mon, 27 Jan 2020 09:40:07 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id 63sm2445716ywg.96.2020.01.27.09.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jan 2020 09:40:07 -0800 (PST)
Subject: Re: [RFC v1 0/6] kunit: create a centralized executor to dispatch all
 KUnit tests
To:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
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
        Knut Omang <knut.omang@oracle.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20200106224022.GX11244@42.do-not-panic.com>
 <CAFd5g456c2Zs7rCvRPgio83G=SrtPGi25zbqAUyTBHspHwtu4w@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <594b7815-0611-34ea-beb5-0642114b5d82@gmail.com>
Date:   Mon, 27 Jan 2020 11:40:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g456c2Zs7rCvRPgio83G=SrtPGi25zbqAUyTBHspHwtu4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/23/20 4:40 PM, Brendan Higgins wrote:
> Sorry for the late reply. I am still catching up from being on vacation.
> 
> On Mon, Jan 6, 2020 at 2:40 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>> On Mon, Dec 16, 2019 at 02:05:49PM -0800, Brendan Higgins wrote:
>>> ## TL;DR
>>>
>>> This patchset adds a centralized executor to dispatch tests rather than
>>> relying on late_initcall to schedule each test suite separately along
>>> with a couple of new features that depend on it.
>>>
>>> ## What am I trying to do?
>>>
>>> Conceptually, I am trying to provide a mechanism by which test suites
>>> can be grouped together so that they can be reasoned about collectively.
>>> The last two patches in this series add features which depend on this:
>>>
>>> RFC 5/6 Prints out a test plan right before KUnit tests are run[1]; this
>>>         is valuable because it makes it possible for a test harness to
>>>         detect whether the number of tests run matches the number of
>>>         tests expected to be run, ensuring that no tests silently
>>>         failed.
>>>
>>> RFC 6/6 Add a new kernel command-line option which allows the user to
>>>         specify that the kernel poweroff, halt, or reboot after
>>>         completing all KUnit tests; this is very handy for running KUnit
>>>         tests on UML or a VM so that the UML/VM process exits cleanly
>>>         immediately after running all tests without needing a special
>>>         initramfs.
>>
>> The approach seems sensible to me given that it separates from a
>> semantics perspective kernel subsystem init work from *testing*, and
>> so we are sure we'd run the *test* stuff *after* all subsystem init
>> stuff.
> 
> Cool, I thought you would find this interesting.
> 
>> Dispatching, however is still immediate, and with a bit of work, this
>> dispatcher could be configurable to run at an arbirary time after boot.
>> If there are not immediate use cases for that though, then I suppose
>> this is not a requirement for the dispatcher. But since there exists
>> another modular test framework with its own dispatcher and it seems the
>> goal is to merge the work long term, this might preempt the requirement
>> to define how and when we can dispatch tests post boot.
>>
>> And, if we're going to do that, I can suggest that a data structure
>> instead of just a function init call be used to describe tests to be
>> placed into an ELF section. With my linker table work this would be
>> easy, I define section ranges for code describing only executable
>> routines, but it defines linker tables for when a component in the
>> kernel would define a data structure, part of which can be a callback.
>> Such data structure stuffed into an ELF section could allow dynamic
>> configuration of the dipsatching, even post boot.
> 
> The linker table work does sound interesting. Do you have a link?
> 
> I was thinking about dynamic dispatching, actually. I thought it would
> be handy to be able to build all tests into a single kernel and then
> run different tests on different invocations.
> 
> Also, for post boot dynamic dispatching, you should check out Alan's
> debugfs patches:
> 
> https://lore.kernel.org/linux-kselftest/CAFd5g46657gZ36PaP8Pi999hPPgBU2Kz94nrMspS-AzGwdBF+g@mail.gmail.com/T/#m210cadbeee267e5c5a9253d83b7b7ca723d1f871
> 
> They look pretty handy!
> 
>> I think this is a good stepping stone forward then, and to allow
>> dynamic configuration of the dispatcher could mean eventual extensions
>> to kunit's init stuff to stuff init calls into a data structure which
>> can then allow configuration of the dispatching. One benefit that the
>> linker table work *may* be able to help here with is that it allows
>> an easy way to create kunit specific ordering, at linker time.
>> There is also an example of addressing / generalizing dynamic / run time
>> changes of ordering, by using the x86 IOMMU initialization as an
>> example case. We don't have an easy way to do this today, but if kunit
>> could benefit from such framework, it'd be another use case for
>> the linker table work. That is, the ability to easilly allow
>> dynamically modifying run time ordering of code through ELF sections.
>>
>>> In addition, by dispatching tests from a single location, we can
>>> guarantee that all KUnit tests run after late_init is complete, which
>>> was a concern during the initial KUnit patchset review (this has not
>>> been a problem in practice, but resolving with certainty is nevertheless
>>> desirable).
>>
>> Indeed, the concern is just a real semantics limitations. With the tests
>> *always* running after all subsystem init stuff, we know we'd have a
>> real full kernel ready.
> 
> Yep.
> 
>> It does beg the question if this means kunit is happy to not be a tool
>> to test pre basic setup stuff (terminology used in init.c, meaning prior
>> to running all init levels). I suspect this is the case.
> 
> Not sure. I still haven't seen any cases where this is necessary, so I
> am not super worried about it. Regardless, I don't think this patchset
> really changes anything in that regard, we are moving from late_init
> to after late_init, so it isn't that big of a change for most use
> cases.
> 
> Please share if you can think of some things that need to be tested in
> early init.

I don't have a specific need for this right now.  I had not thought about
how the current kunit implementation forces all kunit tests to run at a
specific initcall level before reading this email thread.

I can see the value of being able to have some tests run at different
initcall levels to verify what functionality is available and working
at different points in the boot sequence.

But more important than early initcall levels, I do not want the
framework to prevent using or testing code and data that are marked
as '__init'.  So it is important to retain a way to invoke the tests
while __init code and data are available, if there is also a change
to generally invoke the tests later.

-Frank

> 
>>> Other use cases for this exist, but the above features should provide an
>>> idea of the value that this could provide.
>>>
>>> ## What work remains to be done?
>>>
>>> These patches were based on patches in our non-upstream branch[2], so we
>>> have a pretty good idea that they are useable as presented;
>>> nevertheless, some of the changes done in this patchset could
>>> *definitely* use some review by subsystem experts (linker scripts, init,
>>> etc), and will likely change a lot after getting feedback.
>>>
>>> The biggest thing that I know will require additional attention is
>>> integrating this patchset with the KUnit module support patchset[3]. I
>>> have not even attempted to build these patches on top of the module
>>> support patches as I would like to get people's initial thoughts first
>>> (especially Alan's :-) ). I think that making these patches work with
>>> module support should be fairly straight forward, nevertheless.
>>
>> Modules just have their own sections too. That's all. So it'd be a
>> matter of extending the linker script for modules too. But a module's
>> init is different than the core kernel's for vmlinux.
> 
> Truth. It seems as though Alan has already fixed this for me, however.
> 


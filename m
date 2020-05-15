Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA271D5CE9
	for <lists+linux-arch@lfdr.de>; Sat, 16 May 2020 01:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgEOX4p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 19:56:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:59113 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgEOX4o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 19:56:44 -0400
IronPort-SDR: +gW5bzT2Y4zRcYrJnk9GsxDg3hNvgobVMsRpAItH5zslUZd1fbE2EfBFkewRw7XqpEbRAZyjih
 FUCaj8PIeMoA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 16:56:42 -0700
IronPort-SDR: idmO/FCmWFwyI84fSlrrv1p4NYMqUkV3ao+CGT2nNRfJVfKg1Wtekon+4ksGip4Z3vpkmVTx9w
 ruUPNUMB1/og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; 
   d="scan'208";a="266766439"
Received: from thirum3x-mobl3.gar.corp.intel.com (HELO [10.255.0.216]) ([10.255.0.216])
  by orsmga006.jf.intel.com with ESMTP; 15 May 2020 16:56:38 -0700
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200429220732.31602-2-yu-cheng.yu@intel.com>
 <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com>
 <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
 <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
 <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com>
 <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
 <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com>
 <b09658f92eb66c1d1be509813939b9ed827f9cf0.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzShEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gPGRhdmVAc3I3MS5uZXQ+wsF7BBMBAgAlAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAUCTo3k0QIZAQAKCRBoNZUwcMmSsMO2D/421Xg8pimb9mPzM5N7khT0
 2MCnaGssU1T59YPE25kYdx2HntwdO0JA27Wn9xx5zYijOe6B21ufrvsyv42auCO85+oFJWfE
 K2R/IpLle09GDx5tcEmMAHX6KSxpHmGuJmUPibHVbfep2aCh9lKaDqQR07gXXWK5/yU1Dx0r
 VVFRaHTasp9fZ9AmY4K9/BSA3VkQ8v3OrxNty3OdsrmTTzO91YszpdbjjEFZK53zXy6tUD2d
 e1i0kBBS6NLAAsqEtneplz88T/v7MpLmpY30N9gQU3QyRC50jJ7LU9RazMjUQY1WohVsR56d
 ORqFxS8ChhyJs7BI34vQusYHDTp6PnZHUppb9WIzjeWlC7Jc8lSBDlEWodmqQQgp5+6AfhTD
 kDv1a+W5+ncq+Uo63WHRiCPuyt4di4/0zo28RVcjtzlGBZtmz2EIC3vUfmoZbO/Gn6EKbYAn
 rzz3iU/JWV8DwQ+sZSGu0HmvYMt6t5SmqWQo/hyHtA7uF5Wxtu1lCgolSQw4t49ZuOyOnQi5
 f8R3nE7lpVCSF1TT+h8kMvFPv3VG7KunyjHr3sEptYxQs4VRxqeirSuyBv1TyxT+LdTm6j4a
 mulOWf+YtFRAgIYyyN5YOepDEBv4LUM8Tz98lZiNMlFyRMNrsLV6Pv6SxhrMxbT6TNVS5D+6
 UorTLotDZKp5+M7BTQRUY85qARAAsgMW71BIXRgxjYNCYQ3Xs8k3TfAvQRbHccky50h99TUY
 sqdULbsb3KhmY29raw1bgmyM0a4DGS1YKN7qazCDsdQlxIJp9t2YYdBKXVRzPCCsfWe1dK/q
 66UVhRPP8EGZ4CmFYuPTxqGY+dGRInxCeap/xzbKdvmPm01Iw3YFjAE4PQ4hTMr/H76KoDbD
 cq62U50oKC83ca/PRRh2QqEqACvIH4BR7jueAZSPEDnzwxvVgzyeuhwqHY05QRK/wsKuhq7s
 UuYtmN92Fasbxbw2tbVLZfoidklikvZAmotg0dwcFTjSRGEg0Gr3p/xBzJWNavFZZ95Rj7Et
 db0lCt0HDSY5q4GMR+SrFbH+jzUY/ZqfGdZCBqo0cdPPp58krVgtIGR+ja2Mkva6ah94/oQN
 lnCOw3udS+Eb/aRcM6detZr7XOngvxsWolBrhwTQFT9D2NH6ryAuvKd6yyAFt3/e7r+HHtkU
 kOy27D7IpjngqP+b4EumELI/NxPgIqT69PQmo9IZaI/oRaKorYnDaZrMXViqDrFdD37XELwQ
 gmLoSm2VfbOYY7fap/AhPOgOYOSqg3/Nxcapv71yoBzRRxOc4FxmZ65mn+q3rEM27yRztBW9
 AnCKIc66T2i92HqXCw6AgoBJRjBkI3QnEkPgohQkZdAb8o9WGVKpfmZKbYBo4pEAEQEAAcLB
 XwQYAQIACQUCVGPOagIbDAAKCRBoNZUwcMmSsJeCEACCh7P/aaOLKWQxcnw47p4phIVR6pVL
 e4IEdR7Jf7ZL00s3vKSNT+nRqdl1ugJx9Ymsp8kXKMk9GSfmZpuMQB9c6io1qZc6nW/3TtvK
 pNGz7KPPtaDzvKA4S5tfrWPnDr7n15AU5vsIZvgMjU42gkbemkjJwP0B1RkifIK60yQqAAlT
 YZ14P0dIPdIPIlfEPiAWcg5BtLQU4Wg3cNQdpWrCJ1E3m/RIlXy/2Y3YOVVohfSy+4kvvYU3
 lXUdPb04UPw4VWwjcVZPg7cgR7Izion61bGHqVqURgSALt2yvHl7cr68NYoFkzbNsGsye9ft
 M9ozM23JSgMkRylPSXTeh5JIK9pz2+etco3AfLCKtaRVysjvpysukmWMTrx8QnI5Nn5MOlJj
 1Ov4/50JY9pXzgIDVSrgy6LYSMc4vKZ3QfCY7ipLRORyalFDF3j5AGCMRENJjHPD6O7bl3Xo
 4DzMID+8eucbXxKiNEbs21IqBZbbKdY1GkcEGTE7AnkA3Y6YB7I/j9mQ3hCgm5muJuhM/2Fr
 OPsw5tV/LmQ5GXH0JQ/TZXWygyRFyyI2FqNTx4WHqUn3yFj8rwTAU1tluRUYyeLy0ayUlKBH
 ybj0N71vWO936MqP6haFERzuPAIpxj2ezwu0xb1GjTk4ynna6h5GjnKgdfOWoRtoWndMZxbA
 z5cecg==
Message-ID: <631f071c-c755-a818-6a97-b333eb1fe21c@intel.com>
Date:   Fri, 15 May 2020 16:56:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b09658f92eb66c1d1be509813939b9ed827f9cf0.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/15/20 4:29 PM, Yu-cheng Yu wrote:
> On Fri, 2020-05-15 at 15:43 -0700, Dave Hansen wrote:
>> Basically, if there ends up being a bug in an app that violates the
>> shadow stack rules, the app is broken, period.  The only recourse is to
>> have the kernel disable CET and reboot.
>>
>> Is that right?
> 
> You must be talking about init or any of the system daemons, right?
> Assuming we let the app itself start CET with an arch_prctl(), why would that be
> different from the current approach?

You're getting ahead of me a bit here.

I'm actually not asking directly about the prctls() or advocating for a
different approach.  The MPX approach of _requiring the app to make a
prctl() was actually pretty nasty because sometimes threads got created
before the prctl() could get called.  Apps ended up inadvertently
half-MPX-enabled.  Not fun.

Let's say we have an app doing silly things like retpolines.  (Lots of
app do lots of silly things).  It gets compiled in a distro but never
runs on a system with CET.  The app gets run for the first time on a
system with CET.  App goes boom.  Not init, just some random app, say
/usr/bin/ldapsearch.

What's my recourse as an end user?  I want to run my app and turn off
CET for that app.  How can I do that?

>>>> Can a binary compiled without CET run CET-enabled code?
>>>
>>> Partially yes, but in reality somewhat difficult.
>> ...
>>> - If a not-CET application does fork(), and the child wants to turn on CET, it
>>> would be difficult to manage the stack frames, unless the child knows what is is
>>> doing.  
>>
>> It might be hard to do, but it is possible with the patches you posted?
> 
> It is possible to add an arch_prctl() to turn on CET.  That is simple from the
> kernel's perspective, but difficult for the application.  Once the app enables
> shadow stack, it has to take care not to return beyond the function call layers
> before that point.  It can no longer do longjmp or ucontext swaps to anything
> before that point.  It will also be complicated if the app enables shadow stack
> in a signal handler.

Yu-cheng, I'm having a very hard time getting direct answers to my
questions.  Could you endeavor to give succinct, direct answers?  If you
want to give a longer, conditioned answer, that's great.  But, I'd
appreciate if you could please focus first on clearly answering the
questions that I'm asking.

Let me try again:

	Is it possible with the patches in this series to run a single-
	threaded binary which was has GNU_PROPERTY_X86_FEATURE_1_SHSTK
	unset to run with shadow stack protection?

I think the answer is an unambiguous: "No".  But I'd like to hear it
from you.

>>  I think you're saying that the CET-enabled binary would do
>> arch_setup_elf_property() when it was first exec()'d.  Later, it could
>> use the new prctl(ARCH_X86_CET_DISABLE) to disable its shadow stack,
>> then fork() and the child would not be using CET.  Right?
>>
>> What is ARCH_X86_CET_DISABLE used for, anyway?
> 
> Both the parent and the child can do ARCH_X86_CET_DISABLE, if CET is
> not locked.

Could you please describe a real-world example of why
ARCH_X86_CET_DISABLE exists?  What kinds of apps will use it, or *are*
using it?  Why was it created in the first place?

>>> The JIT examples I mentioned previously run with CET enabled from the
>>> beginning.  Do you have a reason to do this?  In other words, if the JIT code
>>> needs CET, the app could have started with CET in the first place.
>>
>> Let's say I have a JIT'd sandbox.  I want the sandbox to be
>> CET-protected, but the JIT engine itself not to be.
> 
> I do not have any objections to this use case, but it needs some cautions as
> stated above.  It will be much easier and cleaner if the sandbox is in a
> separate exec'ed task with CET on.

OK, great suggestion!  Could you do some research and look at the
various sandboxing techniques?  Is imposing this requirement for a
separate exec'd task reasonable?  Does it fit nicely with their existing
models?  How about the Chrome browser and Firefox sandboxs?

>>>> Does this *code* work?  Could you please indicate which JITs have been
>>>> enabled to use the code in this series?  How much of the new ABI is in use?
>>>
>>> JIT does not necessarily use all of the ABI.  The JIT changes mainly fix stack
>>> frames and insert ENDBRs.  I do not work on JIT.  What I found is LLVM JIT fixes
>>> are tested and in the master branch.  Sljit fixes are in the release.
>>
>> Huh, so who is using the new prctl() ABIs?
> 
> Any code can use the ABI, but JIT code CET-enabling part mostly do not use these
> new prctl()'s, except, probably to get CET status.

Which applications specifically are going to use the new prctl()s which
this series adds?  How are they going to use them?

"Any code can use them" is not a specific enough answer.

>>>> Where are the selftests/ for this new ABI?  Were you planning on
>>>> submitting any with this series?
>>>
>>> The ABI is more related to the application side, and therefore most suitable for
>>> GLIBC unit tests.
>>
>> I was mostly concerned with the kernel selftests.  The things in
>> tools/testing/selftests/x86 in the kernel tree.
> 
> I have run them with CET enabled.  All of them pass, except for the following:
> Sigreturn from 64-bit to 32-bit fails, because shadow stack is at a 64-bit
> address.  This is understandable.

That is not what I meant.  I'm going to be as explicit:

I expect you to create a test case which you will submit with these
patches and the test case will go into the tools/testing/selftests/x86
directory in the kernel tree.  This test case will exercise the kernel
functionality added in this series, especially the new prctl()s.

One a separate topic: You ran the selftests and one failed.  This is a
*MASSIVE* warning sign.  It should minimally be described in your cover
letter, and accompanied by a fix to the test case.  It is absolutely
unacceptable to introduce a kernel feature that causes a test to fail.
You must either fix your kernel feature or you fix the test.

This code can not be accepted until this selftests issue is rectified.

>>> The more complicated areas such as pthreads, signals, ucontext,
>>> fork() are all included there.  I have been constantly running these 
>>> tests without any problems.  I can provide more details if testing is
>>> the concern.
>>
>> For something this complicated, with new kernel ABIs, we need an
>> in-kernel sefltest.
>>
>> MPX was not that much different from this feature.  It required a
>> boatload of compiler and linker changes to function.  Yet, there was a
>> simple in-kernel test for it that didn't require *any* of that big pile
>> of toolchain bits.
>>
>> Is there a reason we don't have one of those for CET?
> 
> I have a quick test that checks shadow stack and ibt in both main program and in
> signals.  Currently it is public on Github.  If that is desired, I can submit it
> to the mailing list.

Yes, that is desired.  It must accompany this submission.  It must also
exercise all of the new ABIs.

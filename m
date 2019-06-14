Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB21E46C2F
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jun 2019 00:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfFNWGO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jun 2019 18:06:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:55527 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfFNWGN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Jun 2019 18:06:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 15:06:12 -0700
X-ExtLoop1: 1
Received: from ray.jf.intel.com (HELO [10.7.201.15]) ([10.7.201.15])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2019 15:06:12 -0700
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup
 function
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
 <7e0b97bf1fbe6ff20653a8e4e147c6285cc5552d.camel@intel.com>
 <25281DB3-FCE4-40C2-BADB-B3B05C5F8DD3@amacapital.net>
 <e26f7d09376740a5f7e8360fac4805488b2c0a4f.camel@intel.com>
 <3f19582d-78b1-5849-ffd0-53e8ca747c0d@intel.com>
 <5aa98999b1343f34828414b74261201886ec4591.camel@intel.com>
 <0665416d-9999-b394-df17-f2a5e1408130@intel.com>
 <5c8727dde9653402eea97bfdd030c479d1e8dd99.camel@intel.com>
 <ac9a20a6-170a-694e-beeb-605a17195034@intel.com>
 <328275c9b43c06809c9937c83d25126a6e3efcbd.camel@intel.com>
 <92e56b28-0cd4-e3f4-867b-639d9b98b86c@intel.com>
 <1b961c71d30e31ecb22da2c5401b1a81cb802d86.camel@intel.com>
 <ea5e333f-8cd6-8396-635f-a9dc580d5364@intel.com>
 <cf0d1470e95e0a8b88742651d06601a53d6655c1.camel@intel.com>
 <5ddf59e2-c701-3741-eaa1-f63ee741ea55@intel.com>
 <b5a915602020a6ce26ea1254f7f60e239c91bc9f.camel@intel.com>
 <598edca7-c36a-a236-3b72-08b2194eb609@intel.com>
 <359e6f64d646d5305c52f393db5296c469630d11.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
Message-ID: <5d7012f6-7ab9-fd3d-4a11-294258e48fb5@intel.com>
Date:   Fri, 14 Jun 2019 15:06:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <359e6f64d646d5305c52f393db5296c469630d11.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/14/19 2:34 PM, Yu-cheng Yu wrote:
> On Fri, 2019-06-14 at 13:57 -0700, Dave Hansen wrote:
>>> I have a related question:
>>>
>>> Do we allow the application to read the bitmap, or any fault from the
>>> application on bitmap pages?
>>
>> We have to allow apps to read it.  Otherwise they can't execute
>> instructions.
> 
> What I meant was, if an app executes some legacy code that results in bitmap
> lookup, but the bitmap page is not yet populated, and if we then populate that
> page with all-zero, a #CP should follow.  So do we even populate that zero page
> at all?
> 
> I think we should; a #CP is more obvious to the user at least.

Please make an effort to un-Intel-ificate your messages as much as
possible.  I'd really prefer that folks say "missing end branch fault"
rather than #CP.  I had to Google "#CP".

I *think* you are saying that:  The *only* lookups to this bitmap are on
"missing end branch" conditions.  Normal, proper-functioning code
execution that has ENDBR instructions in it will never even look at the
bitmap.  The only case when we reference the bitmap locations is when
the processor is about do do a "missing end branch fault" so that it can
be suppressed.  Any population with the zero page would be done when
code had already encountered a "missing end branch" condition, and
populating with a zero-filled page will guarantee that a "missing end
branch fault" will result.  You're arguing that we should just figure
this out at fault time and not ever reach the "missing end branch fault"
at all.

Is that right?

If so, that's an architecture subtlety that I missed until now and which
went entirely unmentioned in the changelog and discussion up to this
point.  Let's make sure that nobody else has to walk that path by
improving our changelog, please.

In any case, I don't think this is worth special-casing our zero-fill
code, FWIW.  It's not performance critical and not worth the complexity.
 If apps want to handle the signals and abuse this to fill space up with
boring page table contents, they're welcome to.  There are much easier
ways to consume a lot of memory.

>> We don't have to allow them to (popuating) fault on it.  But, if we
>> don't, we need some kind of kernel interface to avoid the faults.
> 
> The plan is:
> 
> * Move STACK_TOP (and vdso) down to give space to the bitmap.

Even for apps with 57-bit address spaces?

> * Reserve the bitmap space from (mm->start_stack + PAGE_SIZE) to cover a code
> size of TASK_SIZE_LOW, which is (TASK_SIZE_LOW / PAGE_SIZE / 8).

The bitmap size is determined by CR4.LA57, not the app.  If you place
the bitmap here, won't references to it for high addresses go into the
high address space?

Specifically, on a CR4.LA57=0 system, we have 48 bits of address space,
so 128TB for apps.  You are proposing sticking the bitmap above the
stack which is near the top of that 128TB address space.  But on a
5-level paging system with CR4.LA57=1, there could be valid data at
129GB.  Is there something keeping that data from being mistaken for
being part of the bitmap?

Also, if you're limiting it to TASK_SIZE_LOW, please don't forget that
this is yet another thing that probably won't work with the vsyscall
page.  Please make sure you consider it and mention it in your next post.

> * Mmap the space only when the app issues the first mark-legacy prctl.  This
> avoids the core-dump issue for most apps and the accounting problem that
> MAP_NORESERVE probably won't solve completely.

What is this accounting problem?

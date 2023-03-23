Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC27D6C707A
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 19:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjCWSsd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 14:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjCWSsc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 14:48:32 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADB218B38;
        Thu, 23 Mar 2023 11:48:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A34B560A;
        Thu, 23 Mar 2023 18:48:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A34B560A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1679597310; bh=9yoyvhXowHGEuMYgXmRUw0CVS4vFN9DeR+lhvNeV+Os=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RKf2GJexb0hK6y93UUJ6zwtPiBSEGWZSdzHlY1qePaQc0+h6JB/v4UKiDebk2vVPE
         E0n5tDstFAAgFgbeFfnRK86oIvtTJONLNzHG7xkbergn6so7j2zMz9Ry5o0plQO+lu
         fcyJGxKWfymWudkpohzVlfuGLB8vsNgJEeSbuZ/Wi65S9AG+Wi33mM2fVeguifu63k
         T7C2+lj2mKl8rHnfGmRWkB91yYA9Ej5S0LlABbDQEMaEbTo5d8YpA3naEupKrekHY+
         NT+/15dsvdAIVm2pXTXH9T9kXFIiz+zlcyV3/R1iAz9YqqdZbk2NYYJ5P7rFX4mUbN
         jtj1Oizg0Z4MA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dave Hansen <dave.hansen@intel.com>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH RFC 0/2] Begin reorganizing the arch documentation
In-Reply-To: <fe5d1e0e-0725-45eb-8b96-edcd12ae4a8b@intel.com>
References: <20230315211523.108836-1-corbet@lwn.net>
 <fe5d1e0e-0725-45eb-8b96-edcd12ae4a8b@intel.com>
Date:   Thu, 23 Mar 2023 12:48:29 -0600
Message-ID: <87cz4zb8xu.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:

> On 3/15/23 14:15, Jonathan Corbet wrote:
>> On the other hand, it *is* a fair amount of churn.  If it's more than
>> people can handle, I'll quietly back away and we'll muddle along as we have
>> been; this isn't something I'm going to dig in my heels over.
>
> I'm not fundamentally opposed to this.  It'll probably cost me a few
> keystrokes in moments of confusion, but that's the price of progress. :)
>
> Things in Documentation/ have also been mobile enough in recent years
> that I tend to "find Documentation | grep something" rather than try to
> remember the paths for things.  Adding an arch/ in there won't hurt
> anything.

So, if I'm not going to get tarred and feathered for this, I'd like to
proceed, and am wondering what the best way is.  Patch 1 is a pure docs
change that won't affect anybody.  I could also apply #2 if I could get
an ack from the x86 community, but that is sure to create conflicts with
tip and get us all more cheery notes from Stephen Rothwell.

I could do the "fix up and send at the end of the merge window" trick
with it.  Or perhaps some of this should go via tip?  Suggestions
welcome.

Thanks,

jon

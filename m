Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F676C712B
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 20:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCWTkR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 15:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjCWTkQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 15:40:16 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A0420069;
        Thu, 23 Mar 2023 12:40:15 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 877CF60A;
        Thu, 23 Mar 2023 19:40:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 877CF60A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1679600414; bh=iQi8Bi9hacIn33KLkpIHUMRozKG0oaFhXdu49BmPO4k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=k0FDr3OzJvgw2XqhhWd1E+YHjnJ0AUrhtyaUyDHHAw+k0FR4HqJBaXoY+3sEVbgQF
         vF5oGSNrO6mX6ul+tg9Xv92MWo56Z0+oF6hIqBNOGq7DeBqt4RcMQF54B3YeX0EtmN
         jFdtJ809hXRkOGpKI08CVbIVTlA/L3Y+luIFMg9GgE+/jUkpVc8Q0MYUv41ewex2ia
         qBxcXulpBMhTTM2qDirqXJXSB4l4XtIIZaT1GakvDrRp8FCp+tv28m+g/u21wq6LU/
         tJDrve0L9Qts0xBIy9uy30HFA0G6iGk0zqKPttP/6tBjyUoSTdAIMJVrvKU05I1fX1
         qPBk0C4u1yCEw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dave Hansen <dave.hansen@intel.com>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH RFC 0/2] Begin reorganizing the arch documentation
In-Reply-To: <498938d3-60a4-6219-a02c-a03e490103c3@intel.com>
References: <20230315211523.108836-1-corbet@lwn.net>
 <fe5d1e0e-0725-45eb-8b96-edcd12ae4a8b@intel.com>
 <87cz4zb8xu.fsf@meer.lwn.net>
 <498938d3-60a4-6219-a02c-a03e490103c3@intel.com>
Date:   Thu, 23 Mar 2023 13:40:13 -0600
Message-ID: <87v8ir9rz6.fsf@meer.lwn.net>
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

> On 3/23/23 11:48, Jonathan Corbet wrote:
>> I could do the "fix up and send at the end of the merge window" trick
>> with it.
>
> That would work for me.
>
>>  Or perhaps some of this should go via tip?  Suggestions welcome.
>
> Since we have so many branches, we'll still have to do the merges
> between whatever branch carries the move and the actual doc-update branches.
>
> The end-of-the-merge-window is nice for us maintainers because we can
> ask the submitters to do any rebasing.

Now that I look...the only thing in linux-next currently that conflicts
is the shadow-stack series; if that continues, it might not be necessary
to do anything special.

Thanks,

jon

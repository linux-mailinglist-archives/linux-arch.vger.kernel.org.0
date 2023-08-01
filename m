Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB7676A89E
	for <lists+linux-arch@lfdr.de>; Tue,  1 Aug 2023 08:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjHAGDI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Aug 2023 02:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjHAGDH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Aug 2023 02:03:07 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86528127;
        Mon, 31 Jul 2023 23:03:05 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 775BF3200904;
        Tue,  1 Aug 2023 02:03:03 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 01 Aug 2023 02:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690869782; x=1690956182; bh=qk
        yMf1jROQESc+dKhHjjFPnh08dBcae/QUx9x+GbCtI=; b=XAaP+/+UOTnwvVemks
        YopMYaMcMUz0s+743h6XRCTAg2WKOijp29Zjj1ombpCZS+VMsL/qqBEmiUPz/qpA
        ZIp5w4IeU4KKI0hzCExJW5ycpG4u6w5jrjiPCcFNQib/TBeHIOOEKekZYElsdKHa
        nym0UgIN/QbDR8yXjVyt5EsfgXyoV80wTGbOO56BIhBLmNYu+X6EJiwwXhehGm9l
        icdLq9ZoN9ZMmbKEd7smNtbj6enzC7nGJ+ReduVHIUrxUYoy4zczCxOVXYe/CYv0
        3V7RPMAzPqShh0g4GPkA+WB1+1CT2k3qd+2/jvfVtGh1YpIRNwi19QYgmIkiHHGS
        /geA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690869782; x=1690956182; bh=qkyMf1jROQESc
        +dKhHjjFPnh08dBcae/QUx9x+GbCtI=; b=V8jBjh1HxL7d/irNHDlnPPAOnn6gQ
        MnBvXgkw8Kcsf1Ltw7zPbvfQEvDmi3MDuBRbd6yRrihNN27JsQiQmndqVrk0KnEe
        9QjBQvMytcV5UaWbAdRKPxW5njka3m4UO2GNnIDZQ2CqWGPfAeKnKoscDashq3WX
        hfkeptDhapzV5twxlCT24zS7/OmFfXu9dUZ0E3cZM7Xvp1P1Dn+nnZZDUUC/P26G
        1H+yRk3EgoF+Kp4ky9CyjAgCWz38M7a2+Ojjy4mUP1oXqN6ES1boPJJYdz0FkANM
        lcea4fXYdTo0p1MdB64OvRuyj4yb502ox+17D7EnRMCVDIcV4eJLJGSdQ==
X-ME-Sender: <xms:FaDIZPXoQWDYyYcXI7aYyWNtgvXfQuUWLCk6S_GiRblQ8EEsihgL_g>
    <xme:FaDIZHlqLrMACy7aKb5HsWLRRjf-0hKJxTSexGjiZxBjkUOF4tgBLPtvnnTrs9zXy
    oZ5aidxIVy2DrEd8EI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeehgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:FaDIZLZjWAsnldLMF8roNWDifXJ4QxIQXGXSF5yGCd7Uf3tPOaTmTA>
    <xmx:FaDIZKVk40KF_pmKQnslC9CpYAjXYYevFS-G2yhvjX_4wlgzwCuPhA>
    <xmx:FaDIZJncneE9pXFtFULPv5Kms_B050h3hbu8RJfxDF1t7RUmhlBjbw>
    <xmx:FqDIZLmQSvKyItu5zGcPmO9aT1Vur76WzvC-PJl_GDzdtfVGUI2vAQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A0937B60089; Tue,  1 Aug 2023 02:03:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <2d9c843f-e884-47d3-a825-6402db0a2cb8@app.fastmail.com>
In-Reply-To: <87y1ivln1v.ffs@tglx>
References: <20230721102237.268073801@infradead.org>
 <20230721105743.819362688@infradead.org> <87edkonjrk.ffs@tglx>
 <87mszcm0zw.ffs@tglx>
 <20230731192012.GA11704@hirez.programming.kicks-ass.net>
 <87a5vbn5r0.ffs@tglx>
 <20230731213341.GB51835@hirez.programming.kicks-ass.net>
 <87y1ivln1v.ffs@tglx>
Date:   Tue, 01 Aug 2023 08:02:21 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>
Cc:     "Jens Axboe" <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        "Ingo Molnar" <mingo@redhat.com>,
        "Darren Hart" <dvhart@infradead.org>, dave@stgolabs.net,
        andrealmeid@igalia.com,
        "Andrew Morton" <akpm@linux-foundation.org>, urezki@gmail.com,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lorenzo Stoakes" <lstoakes@gmail.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Linux-Arch <linux-arch@vger.kernel.org>,
        malteskarupke@web.de
Subject: Re: [PATCH v1 02/14] futex: Extend the FUTEX2 flags
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 1, 2023, at 00:43, Thomas Gleixner wrote:
> On Mon, Jul 31 2023 at 23:33, Peter Zijlstra wrote:
>> On Mon, Jul 31, 2023 at 11:14:11PM +0200, Thomas Gleixner wrote:
>>> --- a/include/uapi/linux/futex.h
>>> +++ b/include/uapi/linux/futex.h
>>> @@ -74,7 +74,12 @@
>>>  struct futex_waitv {
>>>  	__u64 val;
>>>  	__u64 uaddr;
>>> -	__u32 flags;
>>> +	union {
>>> +		__u32	flags;
>>> +		__u32	size	: 2,
>>> +				: 5,
>>> +			private	: 1;
>>> +	};
>>>  	__u32 __reserved;
>>>  };
>>
>> Durr, I'm not sure I remember if that does the right thing across
>> architectures -- might just work. But I'm fairly sure this isn't the
>> only case of a field in a flags thing in our APIs. Although obviously
>> I can't find another case in a hurry :/
>
> I know, but that doesn't make these things more readable and neither an
> argument against doing it for futex2 :)
...
>
> Still that explicit bitfield does neither need comments nor does it
> leave room for interpretation.

It may be clear to the compiler, but without comments or
looking up psABI documentation I certainly wouldn't know
immediately which bits of the flags word overlay the bitfields
for a given combination of __BIG_ENDIAN/__LITTLE_ENDIAN
and __BIG_ENDIAN_BITFIELD/__LITTLE_ENDIAN_BITFIELD or
architectures with unusual struct alignment requirements
(m68k or arm-oabi).

I'd prefer to completely avoid the bitfield here. Maybe having
exclusive flags for each width would be less confusing, at the
cost of needing two more flag bits and a slightly more complicated
sanity check, or we could take an extra byte out of the __reserved
field to store the length.

       Arnd

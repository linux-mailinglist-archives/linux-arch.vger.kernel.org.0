Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FFE692765
	for <lists+linux-arch@lfdr.de>; Fri, 10 Feb 2023 20:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjBJTsq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Feb 2023 14:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbjBJTsp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Feb 2023 14:48:45 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E8E6E83;
        Fri, 10 Feb 2023 11:47:54 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D172B5C00E1;
        Fri, 10 Feb 2023 14:37:55 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 10 Feb 2023 14:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676057875; x=1676144275; bh=Ydx8Dguf65
        l39MqCMPUJ81N1jZJppemIQIkyMXa3wXY=; b=HaIJzFysHzEFZKQXI+1gSTcDEp
        mrD37uL26BFl8vHmFjApm9rJj/2tJTIh3UoBysO8zaDx+K4fmncJlHITzceSuI5b
        O1QLnAJOxxUrhd6KIfP3PV8O6bsZxC+O0UThmzd8l3XlhV2eQffqIBj5zOngLyNi
        c+WulbQkzFt67X/gadTzaY01qubxRU5N0nE2FA18KyyA3E2c+wnHr1WuauWRbfcc
        tZnu81INMiBW8KgJVzpnVj1J/lso+7JEDYlfXPXFybM5z+WhmZziDq4B4FXU8RoH
        o7GJpCAnr6UEkNYrbL5Es0dxsQkihQmn9A7Mi93HiHRwJamahcH/0sbcOrvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676057875; x=1676144275; bh=Ydx8Dguf65l39MqCMPUJ81N1jZJp
        pemIQIkyMXa3wXY=; b=kGqJv2xDymeuL8EHXPZ58xuLJq+eILH+Z+UlMkPv0GCP
        6/n8QIHYR3SzkNZXaY3FAlQtrlm+6rajqkRnzR259ubxi2fjMHZu0lpa9cJR6X0S
        5APRVDq0Lh4Q2YVVlR898naLU95xXul9uSYzibnkTerICGCwx7XLCXa7S66zLNb8
        KUVIElndFB1R0dq+YvokOm+qqc/THMbwrMJmiJi951C1YwhY55rg/8b5xLLx3EAc
        GcEuAOrhB5i6Nqs3JauAxA5IuGEvNfj8ZkHjNsLhXOdRmF/Nbw3J0wgF95Zie39z
        l03N50ePCFzElvra7sWQsjgMnjEqPx0O1U/3LPmMLw==
X-ME-Sender: <xms:E53mY0HxjrhhDxOAS5HJPkGBzduyE0dAk6v7xD8ahh3VCDyIUXmRtg>
    <xme:E53mY9U6fw9_-YFNb-T_kLVt86Wd-M-yuGRw82QyjoBdCahY8F5j1jDgqwi3P3dMw
    MDkd_FD-OUmpBPX6YE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehhedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgedvueffledvhfduvdeghefggfehvedutdeigeejtedtieeigfdtvdfgveef
    iedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:E53mY-LCw9Gfjg2uqH0KH8Y2Bk6RixX6B5wjgaM-xsAF0uqm_7HUCw>
    <xmx:E53mY2FyrBrnumc80ZkjYTVrgs98Hh0QgicSzJH5yAXgRHFHC_5ofg>
    <xmx:E53mY6Wd3xU6pV5Ge2VvNsZrj9LHJFfbF7jO4--QgEruQ9QqkVI2EA>
    <xmx:E53mY9cIoW21XYZLHnUT6cUwAtdFgmE661hCi_JfXK9cEG_pemkfog>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6915EB60086; Fri, 10 Feb 2023 14:37:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <aa40847d-1814-4a20-821e-650c8f1f7cad@app.fastmail.com>
In-Reply-To: <639b020c-7419-cbda-64c4-caffd8683131@ghiti.fr>
References: <20221211061358.28035-1-palmer@rivosinc.com>
 <639b020c-7419-cbda-64c4-caffd8683131@ghiti.fr>
Date:   Fri, 10 Feb 2023 20:37:37 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alexandre Ghiti" <alex@ghiti.fr>,
        "Palmer Dabbelt" <palmer@rivosinc.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/24] Remove COMMAND_LINE_SIZE from uapi
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 10, 2023, at 18:10, Alexandre Ghiti wrote:
> On 12/11/22 07:13, Palmer Dabbelt wrote:
>> This all came up in the context of increasing COMMAND_LINE_SIZE in the
>> RISC-V port.  In theory that's a UABI break, as COMMAND_LINE_SIZE is the
>> maximum length of /proc/cmdline and userspace could staticly rely on
>> that to be correct.
>>
>> Usually I wouldn't mess around with changing this sort of thing, but
>> PowerPC increased it with a5980d064fe2 ("powerpc: Bump COMMAND_LINE_SIZE
>> to 2048").  There are also a handful of examples of COMMAND_LINE_SIZE
>> increasing, but they're from before the UAPI split so I'm not quite sure
>> what that means: e5a6a1c90948 ("powerpc: derive COMMAND_LINE_SIZE from
>> asm-generic"), 684d2fd48e71 ("[S390] kernel: Append scpdata to kernel
>> boot command line"), 22242681cff5 ("MIPS: Extend COMMAND_LINE_SIZE"),
>> and 2b74b85693c7 ("sh: Derive COMMAND_LINE_SIZE from
>> asm-generic/setup.h.").
>>
>> It seems to me like COMMAND_LINE_SIZE really just shouldn't have been
>> part of the uapi to begin with, and userspace should be able to handle
>> /proc/cmdline of whatever length it turns out to be.  I don't see any
>> references to COMMAND_LINE_SIZE anywhere but Linux via a quick Google
>> search, but that's not really enough to consider it unused on my end.
>>
>> The feedback on the v1 seemed to indicate that COMMAND_LINE_SIZE really
>> shouldn't be part of uapi, so this now touches all the ports.  I've
>> tried to split this all out and leave it bisectable, but I haven't
>> tested it all that aggressively.
>>
>> Changes since v1 <https://lore.kernel.org/all/20210423025545.313965-1-palmer@dabbelt.com/>:
>> * Touches every arch.
>>
>>
>
> The command line size is still an issue on riscv, any comment on this so 
> we can make progress?

I think this makes sense overall, but I see there were a couple
of architecture specific regressions introduced in v2 that should
be resolved, see

https://lore.kernel.org/all/20221211061358.28035-1-palmer@rivosinc.com/

for the archive of this thread.

     Arnd

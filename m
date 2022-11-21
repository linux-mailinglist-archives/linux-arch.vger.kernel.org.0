Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E98632E62
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 22:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKUVDu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 16:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKUVDu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 16:03:50 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD8AD9078;
        Mon, 21 Nov 2022 13:03:48 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6242A5C006C;
        Mon, 21 Nov 2022 16:03:47 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 21 Nov 2022 16:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669064627; x=1669151027; bh=+2N0DmXIa5
        pM+9pnA2EKqjRscO0wecWm5AymMd2/ZBM=; b=Ac/WV9cmKRAKBtHxLJgYdmRKv6
        FAvEr3UvELi60H4Dh+KmnRRnyQB5qbjNi+wlLUQH9uNGTqRz+gpPV7ZeWzg359/+
        +O5BWD00ndKJzZ9P/QnjQKf0nEbRTlJtddECVOklZuaJytp6xDn0SEsim7C3ATQt
        9ru2aeUfyBMRpThbWME7Up7/grS95Ih7iMpEMyCLR9XJhQ4Reon23BiwZec2Sa7Y
        TxgqGIw4f1laHlzLcMIi7zAhNM6TvYXpcquwyTgD8HUdsGI0QWQPmRksrsH3/h9U
        pDvGIallSwOnjadz1sYfN/vZo7gmKiNTDDhchPOeXgMZBUHvk1lRQ70HSDrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669064627; x=1669151027; bh=+2N0DmXIa5pM+9pnA2EKqjRscO0w
        ecWm5AymMd2/ZBM=; b=tYryUQjVqm1AJLM8R+S2TwmfoRRWyNek5RFJKSfJQhsg
        JUQHAqK+GParL49Rrzqy1kpQVpDQGgOnvzjQlWGaPAN7Solby8k7FpttTvyn9KaG
        26AjI+YZtat2gfc1Yfw8MPbajWNx8gmP6bhy1HSRmcuxqVlFILUNy0v3gKY37dFX
        HlOsw3WG8vVaz87ca/SDdGr+FbsJiaMftpwylnbR1R20SmCAGqR10IzOQJjO5aGq
        SigjPiiw6ngbmCHAGlVe9i4IdusKWl1ThlaNUaIxRz2OA9cQu6RuFptfIMviH8wW
        EEgA69dXU1kSQgYWK2USKMZ8vWxYKNHMNGo6QCsBkw==
X-ME-Sender: <xms:s-d7Yw8rT1m4n47wIB_cpqUHzssn0yM8cGV57cye8koWEKZn3BT6lA>
    <xme:s-d7Y4vrLiMfSrEfp72JyyiEiuHtr5aR4nOjXYSmTgc380h4wikEkoXA4-0ouoKCV
    ckEjM7WMeyE2Ibz9nE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheeigddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:s-d7Y2CEHcgYRfjnjHIV2eKxld5jNg1HhXymAj1hPcInaUgrKM99Qg>
    <xmx:s-d7YwcJ40bL5tB-uEx06uvHvw2JG2C4jWlLfI6gdAS5XVXEWTt1qg>
    <xmx:s-d7Y1Pmfsmnrph5U-BGr9EgdnqZ-lcA8HDScHGVZXMA5cuUT4_Y3w>
    <xmx:s-d7Y43b6YN_ytjK-xtxmFrwnmCqAeM5mivBi5F3pA20m7ltHV8wvQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 26184B60098; Mon, 21 Nov 2022 16:03:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <0fe4e95c-1b55-4ed6-be55-8949bd2a4e90@app.fastmail.com>
In-Reply-To: <9e0cebc4-0ee3-c316-01b3-5131298d70ce@quicinc.com>
References: <20221017143450.9161-1-quic_saipraka@quicinc.com>
 <20221024120929.41241e07@gandalf.local.home>
 <2f19ea9c-10e6-d0f7-2fc9-fb0f896bfc64@quicinc.com>
 <9e0cebc4-0ee3-c316-01b3-5131298d70ce@quicinc.com>
Date:   Mon, 21 Nov 2022 22:03:26 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        "Steven Rostedt" <rostedt@goodmis.org>
Cc:     "Masami Hiramatsu" <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>, quic_satyap@quicinc.com
Subject: Re: [PATCH] asm-generic/io: Add _RET_IP_ to MMIO trace for more accurate debug
 info
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 21, 2022, at 16:53, Sai Prakash Ranjan wrote:
> On 10/26/2022 7:17 PM, Sai Prakash Ranjan wrote:

>> 
>> 
>> Thanks for the ack, with this I believe Arnd can take it through his 
>> tree like last time.
>> 
>
>
> Can we take this patch atleast for 6.2-rc1?
>

Applied now, thanks for the reminder,

      Arnd

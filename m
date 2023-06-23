Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2590C73B24D
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jun 2023 10:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjFWIHO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jun 2023 04:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjFWIHN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jun 2023 04:07:13 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913211BE2;
        Fri, 23 Jun 2023 01:07:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 00E905C00AE;
        Fri, 23 Jun 2023 04:07:12 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 23 Jun 2023 04:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687507631; x=1687594031; bh=dB
        4MvOq9La9HYoQdGbRIWUCrkjRx1qjCnmDH5dNdClE=; b=G5BssPj+eEkx8Shb0G
        Ra49Nv1ek5YqpZn1Iu8uQ5sW/Mzh4xpqaDgzsai96WZNF5DCeuEBLdEzRXFo1Scx
        mHQs0EmOYrfw+0oeXUdZox7G+C1wT3JWIGQFws3lvHHy6bR8/WddyjS61sTQvDDw
        zrw5eZBDmGp5CHsNBOty++lsKVll+PvdhvHQW26H8vdfqAI3Awp44PpxLRGIXDo3
        VStlEyLTlQXbHNnjU5t74+0HSNQrXzTvBSC8HyW7ktK/LwOpdTTolr4m0X+Dy0T4
        MHsnn21IazSXnL6MSE91q33pIaCuKDasx78DrFRfaMOXCHaZJ1ftxvfBjmyfFwol
        fuRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687507631; x=1687594031; bh=dB4MvOq9La9HY
        oQdGbRIWUCrkjRx1qjCnmDH5dNdClE=; b=Soh679IQEAvAnobbwqge9pp41xyd0
        OpfLpxy7QQDcqvcBdDWF1QGXZwKsGM2XBDIaRPUScNW/v8hvqlcumCFdjqaWQtU6
        D7w4l5HeZTS0lUaUq76qJI3rIvgwGkX9TX5/M/xDJo3WtEYzjpgWP5EavAxq6+xa
        FuD+TQGmhPRqiw885VwPyhRvvlceh/7XFN3Gb+uR/jC3gRa0KWacmC9Jfn29Tvj5
        Vh8hdp38gMRhLBQlFxxy2TIEVSArCiHQqUapqGzd/pIkqycprPU6ZnQ07uEwdD8W
        9mMywpP24UoxU5gO+J5LsRfD2bJFQVii64qs1WO76Tkgcy/5Yd1dxngEA==
X-ME-Sender: <xms:r1KVZCuY4G181ZfyY6IXV7c1N4lNEKOP-boUrpzPGJLUUvUDvyp6rQ>
    <xme:r1KVZHeI8WrNr4_M2VrTpfQWe_02pMI2ptAq7N9RRKls0lVLFfd-JWZr2kE3lFg-i
    IOmkzd8leyE3jS6boE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeggecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeetffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggv
X-ME-Proxy: <xmx:r1KVZNxchoBFqmwWO9TFxyLxhAjyhqKFRNkxQFjm5anZfl2d9a2NXQ>
    <xmx:r1KVZNOdVhhThXWJPfMbo_iaXbTiZUJ4xDLiDRyNkOIYq-a0aQmYtg>
    <xmx:r1KVZC-JdOMDiHd31tzkbLjwn897Q9qibueH5CzCZrPMWqUUrbs7GA>
    <xmx:r1KVZIlwBudg0ddG76MtTezUOssMFCiKj2QgIC0no3IKHRFW1PotcA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BF51BB60086; Fri, 23 Jun 2023 04:07:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <0344615b-5148-4641-a99c-ef75a387b261@app.fastmail.com>
In-Reply-To: <038984b4-9e95-bc4b-e763-95bf24426f07@intel.com>
References: <e1a2665d-2e11-7722-a7ae-ef534829ed37@intel.com>
 <20230621223600.1348693-1-sohil.mehta@intel.com>
 <388c9fbb-2782-4990-b432-eeb999308869@app.fastmail.com>
 <038984b4-9e95-bc4b-e763-95bf24426f07@intel.com>
Date:   Fri, 23 Jun 2023 10:06:51 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Sohil Mehta" <sohil.mehta@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] syscalls: Remove file path comments from headers
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 22, 2023, at 22:17, Sohil Mehta wrote:
> On 6/22/2023 8:10 AM, Arnd Bergmann wrote:
>> Applied to the asm-generic tree, thanks!
>> 
>
> Great, thanks for the quick response.
>
> While going through the comments, I was wondering if we have a
> definition of what constitutes a deprecated syscall vs an obsolete one?
>
> For deprecated we have some information saying:
>> /*
>>  * Deprecated system calls which are still defined in
>>  * include/uapi/asm-generic/unistd.h and wanted by >= 1 arch
>>  */
>
> But, I couldn't find anything for obsolete system calls.

I don't think we've ever defined the two terms properly,
I would assume they are used interchangeably here. If we wanted
a definition, 'obsolete' could mean syscalls that are no longer
used by current software while 'deprecated' are those that
are still called by glibc and others on the architectures that
provide them but are emulated through modern variants on other
architectures. Without any documentation on the topic, or a
definite list, other interpretations are equally possible.

     Arnd

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E126C733A89
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jun 2023 22:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344428AbjFPUMS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jun 2023 16:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjFPUMR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jun 2023 16:12:17 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A690A30DD;
        Fri, 16 Jun 2023 13:12:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3B0865C0267;
        Fri, 16 Jun 2023 16:12:11 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 16 Jun 2023 16:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686946331; x=1687032731; bh=Rm
        LztWLM37AdaYSXw8tQ2a76FOwFNZm7vLlBDDTP5Ow=; b=2VBUCoze57ug/WQZWE
        +fRGxJti20jG+9NX5klMvd4/zlggCW8ZTBsEEZS86jjUOBS+mcUohBfIRpH+z6iU
        K8QXGs185V2K+pG/8QQ8wXhGcKL0pmzS+NtFh69kPGd/b6wMbgC4tqff/mkv2WPY
        4BfdCQsnKZ894zHPSU2uTRn14v1XcDUBYKfKREORjBdloWGIjzOzRkgf+Fq7dwTA
        KJn2kpfhlHqFBQhbb57pzvDAMkrkcHj+vp7pUB7h1jIva7oiFMHJThun9sKXgaqf
        AgERsM44EIrH5Jl/rudgQ9IPhkGR+OaaEauHNV/ALe7WLttoAhp1GS0MWEd3ZHer
        HBDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686946331; x=1687032731; bh=RmLztWLM37Ada
        YSXw8tQ2a76FOwFNZm7vLlBDDTP5Ow=; b=VFax/KJrWvA5Q4DLXaZGCDsdITX/4
        degmUN9PFETQl/lctiIheD/gaCKCDFd0JAejKx7d2tu7RAGTf8zlZnYG1lnYg0XA
        c2BBfDm0zF790m4S5AWVbcOaBllwSwQVs/J5+RGwTQVTYFvAsrWCA/nqHQsRGbPh
        hbdHhmjCDaK4MDNBn5UdwfsuMo/zyOCvhX/Efgvts9gkrqS3gi28MFLKk3xfSJhJ
        Aax2ZhnjA35aI0r4zWUKDZhX4EBTdotPp/XhjwbzvSeqmq/K5oqrD+GK2wOkRxh9
        33DyuH4KWFMgT57Rjj9ycQ2HxdCBWq1dVbFxUsOpRtw0a+U15Ir+Vu7Dg==
X-ME-Sender: <xms:GsKMZFRwcuowJFOS9ieO4BJQhOObnNcwosn0l8BPTzevlTUKV1r9TQ>
    <xme:GsKMZOxnC1GNPqFtR946esg8mFf2wYicm9Tv9Rb_xhAS6wwOHkNLcosP1nNpEc5nr
    iCTLT9B7ZW6LOSL_Sc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvgedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:G8KMZK2fKS6_HCgZWP8RAItexCfIsRH_-25wBI-IC2yND9Hjh1csdg>
    <xmx:G8KMZNDWjYssAQLldSmdP9qQmK5mNQpt6vjQ5sL_2ClAJRK7BRPKdA>
    <xmx:G8KMZOgaZ37AaanX7y3cNwlB__gaBaT5YNwyjTPvkmL9Kw6Oz_x1BQ>
    <xmx:G8KMZCbsGm2LNedV9FGwbYZzzhAWG6hECy1ROF43YFa6UIHJ4GXjDA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DAC82B60086; Fri, 16 Jun 2023 16:12:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-496-g8c46984af0-fm-20230615.001-g8c46984a
Mime-Version: 1.0
Message-Id: <c2f3656f-b831-4009-8ee6-a2430c4ac8c7@app.fastmail.com>
In-Reply-To: <20230616183120.1706378-1-sohil.mehta@intel.com>
References: <20230616183120.1706378-1-sohil.mehta@intel.com>
Date:   Fri, 16 Jun 2023 22:11:49 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Sohil Mehta" <sohil.mehta@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] syscalls: Fix file path names in the header comments
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

On Fri, Jun 16, 2023, at 20:31, Sohil Mehta wrote:
> Some of the syscall definitions have moved due to the original source
> file being moved into a sub-directory. Update the file path names to
> reflect that.
>
> A couple of syscalls such as lookup_dcookie() and nfsservctl() don't
> have a syscall definition anymore. Clear the filename and leave the
> original subsystem name intact for reference.
>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

Thanks for going through these!

> Arguably, having filenames in comments might not be the best idea.  If the
> intention is to make it easier to find a syscall definition, it is probably
> faster to just use 'git grep SYSCALL_DEFINE | grep <syscall_name>'.  Please let
> me know if it would be preferable to just get rid of these comments all
> together.

It's probably not worth trying to keep the comments in sync, I'd be in
favor of just removing them all.

     Arnd

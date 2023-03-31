Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBF66D2111
	for <lists+linux-arch@lfdr.de>; Fri, 31 Mar 2023 15:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjCaND7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Mar 2023 09:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjCaND6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Mar 2023 09:03:58 -0400
X-Greylist: delayed 61662 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 31 Mar 2023 06:03:56 PDT
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567BD191F0;
        Fri, 31 Mar 2023 06:03:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EC80A31A;
        Fri, 31 Mar 2023 13:03:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EC80A31A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1680267836; bh=fgi0eL1RHpdLJzwkBb2vvnmgXqVDyXAHJ7IwoRjkJLk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WbPIPwtlm0jYK9bvbBhXG41HIfvABxUc7+c/aT9UgeC3qe7Z1qyf2s+BYkv0OHO/B
         biJTQlRLPBBnTnW6ZKxWeVAz7r8dNXHH5ojWr82PvN4Ng6QIZ9YXp+sWw5Fcv9fJEZ
         VPciTbqFOkQiasC9XnxKwrJyLZxd93swCPPZHUGlvmjX9so6Pu4EU7i3J8BhHqn3KD
         8B9VPCItptOJNJJ8ycPL4kqs2neTdazAelVZ7rmV3+s9ajxzLjOmh16doGbMaUAyap
         myAnbzMeo1peIOMyfauswU1X9PQ4eFtvlZVmiukeS60Tp4Oax4+czoPd6wOFvYACPM
         7v6omL23u9Bnw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/4] docs: move m68k architecture documentation under
 Documentation/arch/
In-Reply-To: <87cz4pdqfs.fsf@meer.lwn.net>
References: <20230330195604.269346-1-corbet@lwn.net>
 <20230330195604.269346-5-corbet@lwn.net>
 <CAMuHMdU=yyEciJD6iU-g90T3Qxg+t27Vz6VuojkhbxdODDJGwA@mail.gmail.com>
 <87cz4pdqfs.fsf@meer.lwn.net>
Date:   Fri, 31 Mar 2023 07:03:55 -0600
Message-ID: <878rfddqdg.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

>>>  :Original: Documentation/arch/parisc/registers.rst
>>>
>>
>> These changes do not belong in this patch.
>
> Why not?  If I don't make those changes when moving the files, the
> documentation build will break.

Never mind, those should be in the parisc patch.  I should know better
than to dig into things while still on the first cup of coffee.

Sorry for the noise,

jon

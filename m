Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679E65FD49A
	for <lists+linux-arch@lfdr.de>; Thu, 13 Oct 2022 08:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJMGS1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Oct 2022 02:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJMGS0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Oct 2022 02:18:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDBC11C6C2;
        Wed, 12 Oct 2022 23:18:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A29761703;
        Thu, 13 Oct 2022 06:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFA1C433C1;
        Thu, 13 Oct 2022 06:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665641904;
        bh=TSm77JhHSOI5WJHsFYrU+vCm1pZiDiibejvje9KTRUo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BoC8ZOb3DSCXhEsKSNLk2/bq9Fz7i5hehIkn0E1+3l7nKXMlF5nve+yIRUOp0Y0QT
         gJ2xNTPsWE0Gz83R4LgWjwUZi4ZvJaccBtoxZHDwLb7i5ewCZXnWqMXerM/KcpfgX8
         A4Xt3ulFsjeDCSGVWKJ9ED5/XD7LdXihkAL7GWu3DYq4jmxzrTOmxwirX98P1ITa5C
         vtfFcx1Bm7fsWmyXWCXxInKhjL+EYLdhNPQEP7MVAOT7Sgx1lelF/3jO6g1WQXwn2g
         kcGi2GHBbuofi7NEpopFk0ig17VZ/iNoQXw81lLwcih98xmrA97Ma/WnftQF4AA5DA
         Ayw6TFTC3qEnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C340A5C0B2D; Wed, 12 Oct 2022 23:18:20 -0700 (PDT)
Date:   Wed, 12 Oct 2022 23:18:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Yunjae Lee <lyj7694@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>, corbet@lwn.net,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] docs/memory-barriers/kokr: Update the content
Message-ID: <20221013061820.GW4221@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221011025809.25821-1-sj@kernel.org>
 <CAE+zRGXBOyyvDsPYVAVwuKT1NzAKgoR939SUu6X5LnhXOUzqyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+zRGXBOyyvDsPYVAVwuKT1NzAKgoR939SUu6X5LnhXOUzqyA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 13, 2022 at 08:30:29AM +0900, Yunjae Lee wrote:
> Hi, the new patchset looks fine to me.
> 
> Reviewed-by: Yunjae Lee <lyj7694@gmail.com>

Applied, thank you both!

							Thanx, Paul

> Regards,
> Yunjae
> 
> On Tue, Oct 11, 2022 at 11:58 SeongJae Park <sj@kernel.org> wrote:
> 
> > There are updates to memory-barriers.txt that not applied to the Korean
> > translation.  This patchset applies the changes.
> >
> > Changes from v1
> > (https://lore.kernel.org/all/20221008174928.13479-1-sj@kernel.org/)
> > - Drop first one, which is not for translation and already pulled
> > - Use better expressions for Korean (Yunjae Lee)
> > - Fix a typo (Yunjae Lee)
> >
> > SeongJae Park (3):
> >   docs/memory-barriers.txt/kokr: introduce io_stop_wc() and add
> >     implementation for ARM64
> >   docs/memory-barriers.txt/kokr: Add memory barrier dma_mb()
> >   docs/memory-barriers.txt/kokr: Fix confusing name of 'data dependency
> >     barrier'
> >
> >  .../translations/ko_KR/memory-barriers.txt    | 149 ++++++++++--------
> >  1 file changed, 85 insertions(+), 64 deletions(-)
> >
> > --
> > 2.17.1
> >
> > --
> 감사합니다.
> 이윤재 드림

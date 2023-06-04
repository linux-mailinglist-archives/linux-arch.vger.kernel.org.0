Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1044721906
	for <lists+linux-arch@lfdr.de>; Sun,  4 Jun 2023 20:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjFDSCP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Jun 2023 14:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjFDSCO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Jun 2023 14:02:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5F7BD;
        Sun,  4 Jun 2023 11:02:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01D0C6102C;
        Sun,  4 Jun 2023 18:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AFCC433EF;
        Sun,  4 Jun 2023 18:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685901732;
        bh=tsgHg/5R2crKomKyj+7Pho6UFoS2AQKQ8Lkd87r9ko8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VPSCfy/0/VfmjnkJ26s0+N3hVhu4/HnrUCquzI2efOtUvDs/4Yi/JlPrsd6b8FGRP
         TyJA63shtiLXlSp/yXjn24pXjiAID96auxASntrPNEF0UlR20gOlNB4B19siwHEReV
         YXzZtRNHKcfkTKg5pZZ5yscqbcv2C/Cdn9lEK+oOgM8n5x0G0biqmaW1qSXevUP/64
         VB8+4Sz9RdRD9EYH2/JGjHGVRbcSZyqYd/mWdQSJbck9euIo+KjHYtBIH+79oSfRrE
         nIjjdTwBqhBroLQzxaKfpO5LPZ6XepshB3PXgabN5/RDVX1omJghFQYfI4eDAIRFVM
         5NMZfTgqRNE4A==
Date:   Sun, 4 Jun 2023 11:02:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Luca Boccassi <bluca@debian.org>,
        Christian Brauner <brauner@kernel.org>, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/3] scm: add SO_PASSPIDFD and SCM_PIDFD
Message-ID: <20230604110211.3f6401c6@kernel.org>
In-Reply-To: <CAEivzxcTEghPqk=9hQMReSGzE=ruWnJyiuPhW5rGd7eUOEg12A@mail.gmail.com>
References: <20230522132439.634031-1-aleksandr.mikhalitsyn@canonical.com>
        <20230522132439.634031-2-aleksandr.mikhalitsyn@canonical.com>
        <20230522133409.5c6e839a@kernel.org>
        <20230523-flechten-ortsschild-e5724ecc4ed0@brauner>
        <CAMw=ZnS8GBTDV0rw+Dh6hPv3uLXJVwapRFQHLMYEYGZHNoLNOw@mail.gmail.com>
        <20230523140844.5895d645@kernel.org>
        <CAEivzxeS2J5i0RJDvFHq-U_RAU5bbKVF5ZbphYDGoPcMZTsE3Q@mail.gmail.com>
        <CAMw=ZnRmNaoRb2uceatrV8EAufJSKZzD2AsfT5PJE8NBBOrHCg@mail.gmail.com>
        <20230524081933.44dc8bea@kernel.org>
        <CAEivzxcTEghPqk=9hQMReSGzE=ruWnJyiuPhW5rGd7eUOEg12A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 24 May 2023 17:45:25 +0200 Aleksandr Mikhalitsyn wrote:
> > How about you put the UNIX -> bool patch at the end of the series,
> > (making it a 4 patch series) and if there's a discussion about it
> > I'll just skip it and apply the first 3 patches?  
> 
> Sure, I will do that!

Hi Aleksandr! Did you disappear? Have I missed v7?

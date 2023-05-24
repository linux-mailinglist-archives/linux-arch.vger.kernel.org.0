Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C413A70F9EE
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbjEXPTh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 11:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbjEXPTg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 11:19:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289E5A9;
        Wed, 24 May 2023 08:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B34C763D22;
        Wed, 24 May 2023 15:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7791DC433D2;
        Wed, 24 May 2023 15:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684941575;
        bh=b0FUtTBTh0b230DQrrfvkGYuz7+7G3AZG0ETnEJJ3Ks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j95lgJ+Yohg9mfGqQLUxF28ayZCi5FdjRe7IMbm5LWz0NAMLBohM79jnUuVSB1i/a
         FTCvpVGB7YInPhpPuHCYzxMXy5h9drvbtJG2wLav05hIkizeIYhG7qg7atk8iORKPI
         VtfxNQYuthGSB4ujydCClupo9zOIt7U18gnUEfYCXLQ/YkGT5GujLJohcIgG39njBi
         3zpofnDund8ZYF3xc7lTuoSI5dPQxpw3BX/ejTrvu9OajI/wNvmqmikBWdTv+GPoPl
         9E3ZXGBlCYLrX5JWiApLZQGzAeSERTdUY2gp2HQ41dnyRnDjk8gjoOnXJuTRcdqrLR
         ZGwTnvzO315AA==
Date:   Wed, 24 May 2023 08:19:33 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
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
Message-ID: <20230524081933.44dc8bea@kernel.org>
In-Reply-To: <CAMw=ZnRmNaoRb2uceatrV8EAufJSKZzD2AsfT5PJE8NBBOrHCg@mail.gmail.com>
References: <20230522132439.634031-1-aleksandr.mikhalitsyn@canonical.com>
        <20230522132439.634031-2-aleksandr.mikhalitsyn@canonical.com>
        <20230522133409.5c6e839a@kernel.org>
        <20230523-flechten-ortsschild-e5724ecc4ed0@brauner>
        <CAMw=ZnS8GBTDV0rw+Dh6hPv3uLXJVwapRFQHLMYEYGZHNoLNOw@mail.gmail.com>
        <20230523140844.5895d645@kernel.org>
        <CAEivzxeS2J5i0RJDvFHq-U_RAU5bbKVF5ZbphYDGoPcMZTsE3Q@mail.gmail.com>
        <CAMw=ZnRmNaoRb2uceatrV8EAufJSKZzD2AsfT5PJE8NBBOrHCg@mail.gmail.com>
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

On Wed, 24 May 2023 11:47:50 +0100 Luca Boccassi wrote:
> > I will send SO_PEERPIDFD as an independent patch too, because it
> > doesn't require this change with CONFIG_UNIX
> > and we can avoid waiting until CONFIG_UNIX change will be merged.
> > I've a feeling that the discussion around making CONFIG_UNIX  to be a
> > boolean won't be easy and fast ;-)  
> 
> Thank you, that sounds great to me, I can start using SO_PEERPIDFD
> independently of SCM_PIDFD, there's no hard dependency between the
> two.

How about you put the UNIX -> bool patch at the end of the series,
(making it a 4 patch series) and if there's a discussion about it 
I'll just skip it and apply the first 3 patches?

In the (IMHO more likely) case that there isn't a discussion it saves
me from remembering to chase you to send that patch ;)

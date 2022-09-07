Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8165B0DFF
	for <lists+linux-arch@lfdr.de>; Wed,  7 Sep 2022 22:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiIGUTR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Sep 2022 16:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiIGUTC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Sep 2022 16:19:02 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7778C122C;
        Wed,  7 Sep 2022 13:18:55 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.87]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MnJZ4-1pEwZm30Ro-00jFso; Wed, 07 Sep 2022 22:18:30 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 8A23E3C09F;
        Wed,  7 Sep 2022 22:18:29 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 5233B3C40; Wed,  7 Sep 2022 22:18:29 +0200 (CEST)
Date:   Wed, 7 Sep 2022 22:18:29 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/8] kbuild: various cleanups
Message-ID: <Yxj8lTPByGnahpWq@bergen.fjasle.eu>
References: <20220906061313.1445810-1-masahiroy@kernel.org>
 <Yxj7/WxCcdIuEHG6@bergen.fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Yxj7/WxCcdIuEHG6@bergen.fjasle.eu>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:+6Nwu2OC6LVhxz57T3bUzhbShAQNzujGOYh5Swks9gAGSNuhGgv
 3W9dyFBrX2ocSVuXQonT+HENxWMlWEOh+qK7uHCdAFrUBjq32X0Q+BVHEIFCfvX7oNJ3QlJ
 n15Nesz7WSk2E7bTk7GAXj6wWGpyJxlt9D/s5sKQkEVXSjwk9ro+xW2N5fd06eS5qItrNhT
 PkR632maEUp5WNndwwSPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zWwwYeRTTqs=:cgzNDHBwJttQC+AMHDj8d9
 CnJ50ps5DP18FN02c9GNcavQxEFLc21F9MUKuDLjRR4w7tWPUglm30hn49UWKl7VkCxuizedE
 0We7WiY7FT4jylXCT40eBhLCupSk9sAjwE6Tt6iydEfC7SiOsIaeH4YN3OJKl1zizffZC0If9
 6+pSc+dmJrjgqI/10PsDR/IvulZbw5xp9XCRoTcin0TxWIcoVklhAZECewQOU5KKeoaNIExn9
 43D9hCIW43pcU1GQgDENur8J12eVRvKa7IjbCjcfN3SAKqSd7bqJ3YkFZkN+r8UVDCbc7Y38g
 sVxfkllox51zVH1heEzvf+iy5Jm+sIUqpfe1D4CSxfk8no3Ig6XT+5hN41HmrnD9K9nm5BeFo
 YGKwDry5RIg5n6igV3o5Zj7kekF1ARe9llc4dyyZPxH7JeB9GMOlq8ZxHw5jxq0s+ffwjzFcB
 WTDFmABhHNJCxgr41LRIFW4rk8sCgSJTPq+lGwTIkPA7MQdQRbEqvWHKtZU40cytgTIPkWTj1
 qRBZfvG/LVFyb0681Rwq9iBFfsmrlryT5CIhhDCCZIYJOI8oX28ptgm44aqb7t83vg17m0VxQ
 /VHl0jyuTHAL83ccRce85upM24hr277oze+vAyozvHnIEQGA6xhtvhrrhEM7OfdpI+m5BvD3V
 i9r7g7oU/Jsg09toOHXnyc/qvAeecIvwvy1tv0o2tVXThOy6IVroH3190OXUHUbmSvc0F6CGJ
 qirb6LYDFupGafo0jyWJKTu/WZJwXZLuSqGDCS6hVkX2p3kcnNXsvBlKXbOUh2AMVLQ6iyZNO
 NoUQmM9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 7 Sep 2022 22:15:57 +0200 Nicolas Schier wrote:
> On Tue,  6 Sep 2022 15:13:05 +0900 Masahiro Yamada wrote:
> > 
> >  - Refactor single target build to make it work more correctly
> >  - Link vmlinux and modules in parallel
> >  - Remove head-y syntax
> > 
> > 
> > Masahiro Yamada (8):
> >   kbuild: fix and refactor single target build
> >   kbuild: rename modules.order in sub-directories to .modules.order
> >   kbuild: move core-y and drivers-y to ./Kbuild
> >   kbuild: move .vmlinux.objs rule to Makefile.modpost
> >   kbuild: move vmlinux.o rule to the top Makefile
> >   kbuild: unify two modpost invocations
> >   kbuild: use obj-y instead extra-y for objects placed at the head
> >   kbuild: remove head-y syntax
> 
> I'm not able to apply the patchset, neither on your current kbuild 
> branch nor on for-next.  What am I missing here?  Could you give me a 
> hint for a patchset base?
> 
> Thanks and kind regards,
> Nicolas


ooops.  It _is_ already on kbuild, sorry for the noise.

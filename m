Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4741375841F
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jul 2023 20:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjGRSGe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jul 2023 14:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjGRSGd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jul 2023 14:06:33 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7144019A
        for <linux-arch@vger.kernel.org>; Tue, 18 Jul 2023 11:06:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b9e9765f2cso35777975ad.3
        for <linux-arch@vger.kernel.org>; Tue, 18 Jul 2023 11:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689703592; x=1692295592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nXz9xDxwT7BaavIhnCmafXwp3/aDUnwPYqui5jTbzSQ=;
        b=ACjbrXYsBjZtBHo79yj+TyLzejWZcJf0M1KE5Nr8CY0VPfyoOEcyveFX72cP3PRP9t
         OW+QPBxUbyr8Ijpyvhswl2xrBaZSWXjSOJj/cHksd1Kyx9grxU4NG/+/tn0y+T2dlw11
         OWW4P6usGYxiGx0rqZIzuFiFsTRyi6Rx/m5mG+5pMRGga9+g8VJKgfzzhWZALToxbsi6
         kWVc8yb26xh+wh0f6jUuOnSNnXYXCv373FZU7EXuGVmWsCzVnlsqoQVDOXwQUPgZDHn2
         fDgPr+2H92WfTB7trYjFZI1vsdTvb5GbxWMIS205xgibFTYYMNJRYgLTU/h0l/g8Gf7V
         WgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689703592; x=1692295592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXz9xDxwT7BaavIhnCmafXwp3/aDUnwPYqui5jTbzSQ=;
        b=TnvoIdKfqjgnG1QhgWQls5ODhSv5f410RXEMxkRRWAhbaOK4Q9YqdjC1Kx+ZoYgjej
         yOn7uylBYbyi9xO6g8bzNKa/r8rt7SXdaVo/thkajv/LLbSRRJqz/dbAKC7p2z8KvLLx
         mVQSxyBEkpc4DNgn/boBgoKieOwwuKCrqoR6HV/7l5JMa5ZGo/CP/eK1UV/vClgTdO+N
         h6EsMBSumiifVDTguX7sNw0bUQh5PphcdrdBFrh3Cn8QXDksUx3dvA0by1DF2MtmfnPq
         kmEM1uEW+U3mugDPMlhYZgIOQOeo7nmuWrfySdbmiQO0uai6IUxaAGmb7EJmeFbdnQyy
         k+iw==
X-Gm-Message-State: ABy/qLavzm4ftfaZ3Ke0Kd2hKsmloWuWucE4sZWhFTIdmYfwEq83ZA8o
        q/LsYkGZGp5ZfvmxNFVwnD8meg==
X-Google-Smtp-Source: APBJJlF7FlQJHF3FMLrPPssG4qg4BrXeUhwWshlLKfnw7NuTDc181VYHZRzG6vsaH9PJ4JGKGoGO3g==
X-Received: by 2002:a17:902:c406:b0:1b9:e9b2:1288 with SMTP id k6-20020a170902c40600b001b9e9b21288mr530425plk.38.1689703591309;
        Tue, 18 Jul 2023 11:06:31 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709028f8a00b001b89c313185sm2171634plo.205.2023.07.18.11.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:06:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qLp5h-002aj7-9n;
        Tue, 18 Jul 2023 15:06:29 -0300
Date:   Tue, 18 Jul 2023 15:06:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC PATCH 00/10] Device Memory TCP
Message-ID: <ZLbUpdNYvyvkD27P@ziepe.ca>
References: <20230710223304.1174642-1-almasrymina@google.com>
 <12393cd2-4b09-4956-fff0-93ef3929ee37@kernel.org>
 <CAHS8izNPTwtk+zN7XYt-+ycpT+47LMcRrYXYh=suTXCZQ6-rVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izNPTwtk+zN7XYt-+ycpT+47LMcRrYXYh=suTXCZQ6-rVQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 18, 2023 at 10:36:52AM -0700, Mina Almasry wrote:

> That is specific to this proposal, and will likely be very different
> in future ones. I thought the dma-buf pages approach was extensible
> and the uapi belonged somewhere in dma-buf. Clearly not. The next
> proposal, I think, will program the rxq via some net uapi and will
> take the dma-buf as input. Probably some netlink api (not sure if
> ethtool family or otherwise). I'm working out details of this
> non-paged networking first.

In practice you want the application to startup, get itself some 3/5
tuples and then request the kernel to setup the flow steering and
provision the NIC queues.

This is the right moment for the application to provide the backing
for the rx queue memory via a DMABUF handle.

Ideally this would all be accessible to non-priv applications as well,
so I think you'd want some kind of system call that sets all this up
and takes in a FD for the 3/5-tuple socket (to prove ownership over
the steering) and the DMABUF FD.

The queues and steering should exist only as long as the application
is still running (whatever that means). Otherwise you have a big mess
to clean up whenever anything crashes.

netlink feels like a weird API choice for that, in particular it would
be really wrong to somehow bind the lifecycle of a netlink object to a
process.

Further, if you are going to all the trouble of doing this, it seems
to me you should make it work with any kind of memory, including CPU
memory. Get a consistent approach to zero-copy TCP RX. So also allow a
memfd or similar to be passed in as the backing storage.

Jason

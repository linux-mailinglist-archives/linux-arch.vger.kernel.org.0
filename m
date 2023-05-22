Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31C170CDA2
	for <lists+linux-arch@lfdr.de>; Tue, 23 May 2023 00:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjEVWQq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 18:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbjEVWQq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 18:16:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC2A9E;
        Mon, 22 May 2023 15:16:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d2da69fdfso4921865b3a.0;
        Mon, 22 May 2023 15:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684793804; x=1687385804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F0P6HslfrTWvvkd+sxrDJVogO9ImCZEfvGMSes8ajjY=;
        b=c4QI6nKEgyQYN+WCJlwfH1Ehd1WdiSTHBa5mFXMnkyR7fJ5iW3DQCWhOaAY1VpIfjZ
         XEEdZiSBFKy9XUCYAFqzRaUn84aWSScN4YfyUazFKtoDwBmx/ZI1OOHd3GhS7EO+Oz1w
         FS3AskP8UD002mfJ4WWduJ5h87RCFYwIjxg/kxmjRiSMKf5R5PZAhvcCYKny0zWk0/ea
         SLWN2YUPOGPi7bdqFHwEPCFLAYboEnmTMNERwIOaEuoblsTqlw2hyvopCGAFMjGlnZ87
         nX/21B/osDDeNXaOnBViypHMMlCv2gdmUFLWL42gnco/Div5JjMF80DZ1bVjrPSdvcL9
         MBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684793804; x=1687385804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0P6HslfrTWvvkd+sxrDJVogO9ImCZEfvGMSes8ajjY=;
        b=BOC4YLT9Xfck0ehllL1Fy/UzJpqfENCKr8tO9vKBd5/1VrdOMpl6A8/dvhAcqJ1W2f
         VYudo29xGJYllJFshd/8ipAGjOQq79evkYG7DS1VYFUaemDpw5QNhIQo62O6Kqz0m2C4
         /X1SFm4tJD1tljCBvw3byHLNP1vlqNMfTNKFHiQc+UZBxORdl7f3Ybl+NE+vHspkGtqM
         Q/NzW6klI30vQ7lKlY6/iKu7fp1dSQT4nD/fvu0gcOC25O0T1JgmCccZC3wk+LFGNb2M
         E/5pNIVyCefCnOfeJbbog/Syf+2TgrUoDdezGEp526XeewOn2tZ6m9jvt2DA3+igSt41
         ppbg==
X-Gm-Message-State: AC+VfDwds3QV19foXGxDo1yiBlDjX3gqeS7GK/yLd2t+/Ad05ecSv3UO
        t1YJYfI3QPfnnxg2wcHnHS8=
X-Google-Smtp-Source: ACHHUZ7IMWVXcC7UHrHSQO5esotE6d8hiZr82hkfDWihopKcBntraXV7PcsqvDjceJ3cyhItj0Sjdg==
X-Received: by 2002:a05:6a21:33a6:b0:10b:91c5:45a8 with SMTP id yy38-20020a056a2133a600b0010b91c545a8mr4715151pzb.15.1684793804357;
        Mon, 22 May 2023 15:16:44 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:54fa:e8a7:76de:888d])
        by smtp.gmail.com with ESMTPSA id n14-20020aa7904e000000b006470a6ef529sm4556581pfo.88.2023.05.22.15.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 15:16:43 -0700 (PDT)
Date:   Mon, 22 May 2023 15:16:40 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v5 16/44] Input: gameport: add ISA and HAS_IOPORT
 dependencies
Message-ID: <ZGvpyETg8dug9Awm@google.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
 <20230522105049.1467313-17-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522105049.1467313-17-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Niklas,

On Mon, May 22, 2023 at 12:50:21PM +0200, Niklas Schnelle wrote:
> diff --git a/include/linux/gameport.h b/include/linux/gameport.h
> index 8c2f00018e89..4d5720022b63 100644
> --- a/include/linux/gameport.h
> +++ b/include/linux/gameport.h
> @@ -167,16 +167,21 @@ static inline void gameport_trigger(struct gameport *gameport)
>  {
>  	if (gameport->trigger)
>  		gameport->trigger(gameport);
> +#ifdef CONFIG_HAS_IOPORT
>  	else
>  		outb(0xff, gameport->io);
> +#endif

Contrary to the cover letter, this is still kind-of runtime detection
(i.e. broken drivers will silently stop working), we need to have
dev_err[_ratelimited?] here and below.

I also just posted a patch reworking this a bit so this and the chunk
below can be hidden in gameport.c.

Thanks.

-- 
Dmitry

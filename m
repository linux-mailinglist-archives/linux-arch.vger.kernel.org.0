Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179F44EB5F1
	for <lists+linux-arch@lfdr.de>; Wed, 30 Mar 2022 00:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiC2Wbg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 18:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbiC2Wbe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 18:31:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDAF6A421;
        Tue, 29 Mar 2022 15:29:49 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c7so205995wrd.0;
        Tue, 29 Mar 2022 15:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=YC5CL4pcRYovUmMmopc0W3NdAijbvR/lufVR7zvrMCqXy1BoTWrw0XFP7mcWJ2B8OB
         2XPrN/3labR55UrMTGBC9bKJLSA6La9ZQyCDiIbhk5IfO2vlZu+gpaM8mnnV4gOl1A+n
         9ALjs7Urg8dFw+H7bxnwyRsLqKPQws6mHMtoUar6CBLvh0hLjIO6gx25mIDAhk56Zs0p
         8JFPsKksdScdtWy/r92O/g6UbuSTI2GESIrRhen4ENtiBzDhqJfUmnrZE9l7IcCNxVtp
         ONlw9qpfVqbkH8zYRzlrgyZCegWll3djSyyCo/HwiMUv961OVJo9/Vs37mPmbKvee+tF
         pj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=1WvpY3whLI6idq6fGGBYsrp41zdjegz9jxor7ae1haEWakrxJ1IKY19LUVSIQjl8WS
         lHRTW9sMWpz8WQLIq2eJ0Q+mHOBcWybQaHnNWeQqn3GIyf1+e+X3fEgqkEJG3FYb8msS
         MElCKJFcda/plOYvWsyo3vjJYlcngfU4P2fVhLYhvDzjO9t94If7z4tenGpWDmE82Dtp
         sVStrJunFIEJP95zGH9QoIVAFy2UmywLv+InU25n+942r0UnmFCx1wUb/LvaavwjvRyD
         rxdVlvgFEPhE7LgShdcTrUxUgIuzFQVQBkt6xn4AxLHyK5Ki1WDDmPLDyRaVZOmmSXfg
         i4gQ==
X-Gm-Message-State: AOAM531Vz5d9UOhMjFNDywlwaTydsYpEoQ+tC45WAPURBl8WrsI65opf
        3aZTTWYCe9uCEmi4/GwILGY=
X-Google-Smtp-Source: ABdhPJwcf9c0HMW10vBbnszwWa1xfOfp+5ZOWLzHLaQFclGIN7LRODX6nVTRyYvOPaPTPc3+eQM8Zg==
X-Received: by 2002:a05:6000:1862:b0:204:e417:9cf8 with SMTP id d2-20020a056000186200b00204e4179cf8mr34626643wri.593.1648592988384;
        Tue, 29 Mar 2022 15:29:48 -0700 (PDT)
Received: from [172.20.10.4] ([102.91.4.187])
        by smtp.gmail.com with ESMTPSA id m11-20020adff38b000000b002058f767c58sm15396451wro.30.2022.03.29.15.29.42
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2022 15:29:47 -0700 (PDT)
Message-ID: <6243885b.1c69fb81.300a3.cafe@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Gefeliciteerd, er is geld aan je gedoneerd
To:     Recipients <adeboyejofolashade55@gmail.com>
From:   adeboyejofolashade55@gmail.com
Date:   Tue, 29 Mar 2022 23:29:37 +0100
Reply-To: mike.weirsky.foundation003@gmail.com
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Beste begunstigde,

 Je hebt een liefdadigheidsdonatie van ($ 10.000.000,00) van Mr. Mike Weirs=
ky, een winnaar van een powerball-jackpotloterij van $ 273 miljoen.  Ik don=
eer aan 5 willekeurige personen als je deze e-mail ontvangt, dan is je e-ma=
il geselecteerd na een spin-ball. Ik heb vrijwillig besloten om het bedrag =
van $ 10 miljoen USD aan jou te doneren als een van de geselecteerde 5, om =
mijn winst te verifi=EBren
 =

  Vriendelijk antwoord op: mike.weirsky.foundation003@gmail.com
 Voor uw claim.

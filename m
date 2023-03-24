Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC666C7D61
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 12:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjCXLlz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 07:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjCXLly (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 07:41:54 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2501E5CE
        for <linux-arch@vger.kernel.org>; Fri, 24 Mar 2023 04:41:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id o2so1565370plg.4
        for <linux-arch@vger.kernel.org>; Fri, 24 Mar 2023 04:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679658112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZeK4ZJ1o6tGrUVsDjmi+mms9O6S9hGyBZoeD/hC1EM=;
        b=hLooiSYOqjzDI547IKxg4znAiHjjN039IVNhoTti48JMFNUDh0HZ2FD9I2SfD+Ss5z
         GlW/Qk0Cfws/SIrfnb6+ZLx7VnBI1rQRM2eSapt19MRcIrAVW1kq5RyKkMREk3m/tzsF
         ZscRQhqgaHCm1IEer0+yQOYq1azXuQjKeEV6L/OTzB6qfIjvhcit249vHhlJ96/Ar8XS
         H+Lwbj/JttddVtD+8qLbu86vpLQlZWfPOKNzCi5nlPjDbjXBha6LwQJzBF7xf0n6M4k0
         niD1aXHq09u+TiMrkkfQnBIikyl4f77KmL/LI7fnKQIupL4ztNdcE+pxXzQQPfKnZCtL
         NG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679658112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZeK4ZJ1o6tGrUVsDjmi+mms9O6S9hGyBZoeD/hC1EM=;
        b=QNryQLy0Hqvcjt76SYnAcqtBtZCVP+D+PqXFxb3Qcsz93Ih5djtiH3leV+TVUnKRtI
         /mHNG3k2lvHz3RabqMr4pzz3S9zXhF/a3Dnqu6dxdM/nesvEexXgcgOlOBsLcZ3HD+mI
         aQbQaVTSMFUuB1dpjv1aeIasU2s1MDiNSQN2vpNHasg6UF6hCue6Nm4f1uFDY1XwRoqk
         3NGBhFjP0Pq0SgSSRxm7OkNfJAeVe9TjaEfIpVLHYaqOjkipS6i/IWMLlQcWy+w5MEXK
         AxkP5i1DyS4MAgZRtTQl2/2BD4/I2TX7AJkoq2dqjdxBcXdJzXbukWOGf3pcRtOIkcl9
         X6mw==
X-Gm-Message-State: AAQBX9fl919SdN9B1OpEMqbmHSpBP+dWfVpQLohLhz++BC8W5jHmyQfg
        lGpb0s2t+2zzSzaiGXj5TXqnNWG4VZu0aO4XL7c=
X-Google-Smtp-Source: AKy350Y4cdHUAVb3s1Dukk/lC88GDJcK9+6jhFM7DJqD2X0HBbjO8/GaCNJ8h47ilrz9aRtZYh9lhFZrX1upuzMb+10=
X-Received: by 2002:a17:902:ee13:b0:1a1:add5:c35b with SMTP id
 z19-20020a170902ee1300b001a1add5c35bmr744162plb.10.1679658112157; Fri, 24 Mar
 2023 04:41:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:c7c3:b0:40a:64ae:d236 with HTTP; Fri, 24 Mar 2023
 04:41:51 -0700 (PDT)
Reply-To: fionahill.2023@outlook.com
From:   Fiona Hill <kevinhansen8819@gmail.com>
Date:   Fri, 24 Mar 2023 04:41:51 -0700
Message-ID: <CA++QgS_G1vq2nsvfpjfrosuBm7vY=sfHpEJ5Ze1ua+u7GEkDqw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

-- 
Hello friend did you receive my message i send to you? please get back to me

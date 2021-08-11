Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE7B3E8BCA
	for <lists+linux-arch@lfdr.de>; Wed, 11 Aug 2021 10:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbhHKI14 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Aug 2021 04:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhHKI1z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Aug 2021 04:27:55 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C6FC061765
        for <linux-arch@vger.kernel.org>; Wed, 11 Aug 2021 01:27:32 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e186so2558599iof.12
        for <linux-arch@vger.kernel.org>; Wed, 11 Aug 2021 01:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Suo1PJGKQxPGS27pW79MeFl2fTjVvoONrdUzPhZtiNg=;
        b=Ktq45nQo4t9E1Hdjd/pWzSkmTuM5bF65184pVlONPqPr3Jm2NZHbAn1ThA//sXCTni
         1jC2ZY8TjaqfiwgJNm1Y9zOrQiF4xLHD6TLfHKcafNvTigDoZWSuW/Wc+XYSGaYQJRe0
         cCFmoUewsr75YOZHqQ/OEypEnXxfS+mqF3E5RHAqTWVzE/p/aMPpFOmzLttlwN735Z1W
         d/ku77UBypIjrVrkEgyWyDx+CkwAiHVHQlAaSNRMsak+2sZitP3uvWaUlYckHH5pjHBx
         6Sy2bkuAzx+GJtjnJvFzxjo0JOODI9EJ6lbrY1I0N/5WrU7EFy10oEgf/XkKOm6gA8Tn
         rm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Suo1PJGKQxPGS27pW79MeFl2fTjVvoONrdUzPhZtiNg=;
        b=tgTbu5WBW7KqBY/lX3u3C3kWYxgm4e+FU7dQ/BXg7KQguuVGtlojMwBiahJxlxe+dQ
         aINCBFHXlDeJKmW4sk4U7VFas87XMGxaAIEgdwntmxVmRCY6LWizfZ/JF0wp3c/tiUtM
         /oTymAG7WEPrKYRoVyYNzO6yD3sf4NUWshlsifLvgopvvxWU01Vs8RVXCm83h+OMALoL
         q4c/7Lh9TFFDlisb1gt0Rm+kBb/4R4X0TLqeYUAfXfAbFNwNv3ChVZzRaShnBBVlS2na
         sDFoEfL5B28AkdsOWqGr2/qLWO1K5PJ5JRXmKtC3cTR2u41ylxhWlX919yOew/MAD3Eu
         OIxw==
X-Gm-Message-State: AOAM5334jDIjpxIHuYggTVg0sGHcskJ5CRxOtGaRzFCPrta/KLAOGfdv
        pkIuwNo71OmR1dLY1aGsmsv1REXS/uvzYMp0Wcg=
X-Google-Smtp-Source: ABdhPJxXUf6fCLSmN9gvLuUf7MU/yeLN0UbqP2gsxZUKKP4VIgJevcgxQMIvAde4j5Xw+jnRD4oAs2LeOARr2/F8j1U=
X-Received: by 2002:a6b:670a:: with SMTP id b10mr16281ioc.137.1628670452174;
 Wed, 11 Aug 2021 01:27:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:d103:0:0:0:0:0 with HTTP; Wed, 11 Aug 2021 01:27:31
 -0700 (PDT)
Reply-To: stefanerlingperson@outlook.com
From:   Erling Persson Foundation <sheerobs9@gmail.com>
Date:   Wed, 11 Aug 2021 09:27:31 +0100
Message-ID: <CAHj-_5wSjvOnn+5NBxWsmNCS9+F+0cp3Ld_asnTu0YPj5ZJNnQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--=20
Nachricht von Stefan Erling Persson, Inhaber der philanthropischen
Stiftung der Familie Erling Persson, und Sie wurden als Wohlt=C3=A4ter von
3.5 Millionen Euro aus unserer pers=C3=B6nlichen Spende im Jahr 2021
ausgew=C3=A4hlt. ANTWORT AUF ANSPR=C3=9CCHE.

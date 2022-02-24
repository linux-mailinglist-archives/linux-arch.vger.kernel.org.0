Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86CF4C2920
	for <lists+linux-arch@lfdr.de>; Thu, 24 Feb 2022 11:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiBXKQw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 05:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiBXKQu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 05:16:50 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3761528D38D
        for <linux-arch@vger.kernel.org>; Thu, 24 Feb 2022 02:16:21 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so919747wmp.5
        for <linux-arch@vger.kernel.org>; Thu, 24 Feb 2022 02:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=M+9E/4kdcDHX+kADMEgL+77UKaeIJe66vooZh14SxpQ=;
        b=J1XttCVHQmSAfgTTkZRPiLhdvxpMVbe4bPXYmdAGmzjU3fzOwnX7g8PNXmZhRIrj9q
         PjpLMPn6E/DWY+qDK58JJgM+o6rtneSIkdSBdgdyZLxoPMryMTff20aZqPRDzkcNugGS
         AFxrUki/Rap7cYcJAw+8rJ3oGUoDygURs01EThnyhh3lDloaLE7fxXxaRD+DCd77bmRV
         Hkkzrn86LitySmn0OJ8Q6u1pTehfGDPriQ2a4jWbwsnM9vQjkZfgUPhR2ky6OFL2EHbG
         EOBAhpwgVdhhn7goWIvPN3fwrESxYkMVrUuILH3d+GcrcWEC4FfAPiJig7lXmf5BlP43
         tg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=M+9E/4kdcDHX+kADMEgL+77UKaeIJe66vooZh14SxpQ=;
        b=mbAwxphhV5E129LbxomNeUnt7gcVRHHWgw809Acz7sLyGr/0ElW/BvTkfx8x9Mk9hO
         GySTzfFtUXMMdDkXkDhuY/wCbaS9afnNCKSAmng1G9PpzMpeAQnxXraiiDOSHLc55Do6
         gpLjU2UHD+KaBu8UH5uAcXoi2Hwl+qpG5ePVe9PaTkXO7yMeu6va74Jq0ZOntB8CKe99
         YuE3yLAHryaqprqmwiw0I7y2ZfoshD6HuzBDmp5gmn792pfmWCTO2wEBNH48MjJK83KY
         lbxUTkc82HlHHEN0NQKC+1v9QP8GQ5R3mj73z/hmZfW5lTUZ/vnf8Vi9Q94ON/OszPep
         v9ww==
X-Gm-Message-State: AOAM530HjUaeRzwAg6cUE4SxIBpkqa7SRTCFbHzXVejBz9SMYRHAS7Ae
        LStmxGhOyskgK25Kafr/shIe/883DUaODPMKn4M=
X-Google-Smtp-Source: ABdhPJwIvuPEj66LyG8ZHS5PnlZPk9OfM3hMsqkRbNVkBYf7TvwL29aAyCjKxwPcyO7El+yo/qcEPwpzraP7YNiHAU0=
X-Received: by 2002:a05:600c:35c4:b0:37c:debf:6f2d with SMTP id
 r4-20020a05600c35c400b0037cdebf6f2dmr10770763wmq.142.1645697779635; Thu, 24
 Feb 2022 02:16:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6020:907:b0:196:d190:b904 with HTTP; Thu, 24 Feb 2022
 02:16:18 -0800 (PST)
From:   see peter2 <seepeter85@gmail.com>
Date:   Thu, 24 Feb 2022 11:16:18 +0100
Message-ID: <CAGyXJ3HCcJf=2tmPctbn5goOqBMOq8qcejx7SSk-dNqWfHE11w@mail.gmail.com>
Subject: Dear one,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,LOTTO_DEPT,
        MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,T_SHARE_50_50,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:342 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [seepeter85[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [seepeter85[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_SHARE_50_50 Share the money 50/50
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 LOTTO_DEPT Claims Department
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dear one,

 My name is Mr.peter see, I am the manager foreign remittance department of
Bank in Cote d'Ivoire Abidjan Africa. I have a business proposal in the
tune of ($3.5 Million United States Dollar only) after the successful
transfer;We shall share the fund in ratio of 40% for you and 50% for
me,while 10% will be mapped out for any expenses we may incurre in this
transaction if any. Please if you are interested,So we can commence all
arrangements,And I will Give you more information on how we would handle
This project. Please treat this business with utmost Confidentiality and
send me the Following information's below to enable us commence immediately

Best Regards,

 Mr.peter see

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081C251B3DA
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 02:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiEEAFY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 20:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbiEDX5a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 19:57:30 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EB64ECFA
        for <linux-arch@vger.kernel.org>; Wed,  4 May 2022 16:53:52 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id e189so2798772oia.8
        for <linux-arch@vger.kernel.org>; Wed, 04 May 2022 16:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ampHH5WJLIBWSsxWwzVjbk5pO9UBFxn81pZ6QIDzZtY=;
        b=FNIAYmcejzHfmZlCiIHYgT6erzQSC9gmgFmOiY6jxN7WvOxDyBQzTWQXuf0QQSLa76
         OjSO2mcjza7TfryU2Yt8mJxkT+qWMSaleALBlY7mfzTxVPd1JjVxyw0EBBmPWGPP2G3/
         EjJyRmLlkni3UqZSkuePTk9fUuzh8hCavLsGDVWv86trmI+S5ZFLXA2M/ALU/OX9/Dog
         FVBSuENuyzE6Zj/zsEo0v3B7v/NSoUlBUw+9pnAspgHs/c6uItO7g+7oIPUnQ5P8rHEg
         Uw50ND4b7eJCcoszBXUiYPFOBzRcktyN3Nzu2+vze2IYlqC3egzGpfENgoTcj3C+TYFW
         rVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ampHH5WJLIBWSsxWwzVjbk5pO9UBFxn81pZ6QIDzZtY=;
        b=dYC3IY/1wE+Xk5ACNDZr6e/YzMBNMrBVfvTvCx8PO0DnxMI6EPK2gWUGyRY0dueYQY
         PEzgmFBPOn9Ln+yBbgHeQquhVf9RzhuRUNTy43ZID7F+4kCruViM+hKo9lVSNKvco+nt
         +FL0T6FO1n1up4Nw+M4V7G5mhtS//V45F3Kg4Xl3VPWJSL9h9XBuSR3tQ9mcWGH8F4Ym
         Bp10qllVG8ayR6cdhURNC3YkxXWZKWw1KaCbq/9T6hAfGeTbS/bgaNuIX5ZJ4sVv73zp
         o5l+1z9ou5HZhq8sBs1T2dp9CNS4l9IYULsgAvPSNgJZuHXcmpHAx0kiht1hByySsokZ
         mDpg==
X-Gm-Message-State: AOAM5323BuittiCHFFmbQReFcdfaYAtV4TkdXOtxCjNAvHaq4B02AAhB
        ufQW2SCeggRvkgqlunFJ6nJhnDSPXU5r2vLH7D8=
X-Google-Smtp-Source: ABdhPJwYlgNc/5bis71DucVvd+ZioHPl83VcBeyXc51mm1mJBTXR/7J8yaMUf518PLLny14+iH6/by9bmkLUTmJvSMI=
X-Received: by 2002:a05:6808:2019:b0:326:6d24:dfd9 with SMTP id
 q25-20020a056808201900b003266d24dfd9mr1003508oiw.183.1651708432083; Wed, 04
 May 2022 16:53:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6802:1a9:0:0:0:0 with HTTP; Wed, 4 May 2022 16:53:51
 -0700 (PDT)
Reply-To: ortegainvestmmentforrealinvest@gmail.com
From:   Info <joybhector64@gmail.com>
Date:   Thu, 5 May 2022 05:23:51 +0530
Message-ID: <CAP7KLYhOuoEX9VpuWFzfxXW3-SdA7X=MyCKJ7oAAs4__V29BXQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:241 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5022]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [joybhector64[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [joybhector64[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

-- 
I am an investor. I came from the USA and I have many investments all
over the world.

I want you to partner with me to invest in your country I am into many
investment such as real Estate or buying of properties i can also
invest money in any of existing business with equity royalty or by %
percentage so on,
Warm regards

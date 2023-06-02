Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B454D71FD89
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jun 2023 11:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbjFBJUh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jun 2023 05:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbjFBJT5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jun 2023 05:19:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9D510DF
        for <linux-arch@vger.kernel.org>; Fri,  2 Jun 2023 02:18:55 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so2547129a12.1
        for <linux-arch@vger.kernel.org>; Fri, 02 Jun 2023 02:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685697534; x=1688289534;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMDHAGot5D61eQSkGibzV4peKRC+G0XEae9mhUtejFk=;
        b=SWo66ZpCpzIDSReogD23fr1upaHouMk8ctCEJXZZFHQawN6X5YMLCMQ+LErP9XZ0Gx
         OWfjvHU6TwaixSPmCyiJtZj2KGaWG2o5YAfsQejIw73Ovmx7nhURisel9qkit2BZJVPB
         Cfw9SqfcrYJ5z/5sU+mz28kc2nGHW0ZxG8Xy3GWUsrk0Yr2LGBFNsSDWP/jfrtpyOUzl
         NS9DE/L90Ixa1p2ifQgndqAGYMnZeC3nslWziHlX7FmBzH1aOqZCdhBWitOEnI+uDuMk
         rp+n5pKzTaqUC+wKpz1drDn9EEZCkKJtK+YiICvuvtq+CecAiCmpIVzF6fIJIOBbkHvW
         Drrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685697534; x=1688289534;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMDHAGot5D61eQSkGibzV4peKRC+G0XEae9mhUtejFk=;
        b=gmAY5IAGH0EXpmItKg1/pGUAxrLYu1Vgtel7ibriz5E1pWAjFY5nXAWwer0w/BkI8q
         Tt0gxfZIJZk1tvsfCu/X/bwx6+nKf6kroUJIazBOnqd15arLz4Mh1a5z6QhMKqdRcedV
         /mLLxo0O7022zHlQAiVI1q1yEmRMo21t4ALt7ek160jOlR+Qv1nS1TLCjTLskf0oa8Dv
         J57ProUNG9A8UlVQBnhJmKpvKPhRcJnx8Kryp4yUH3gadh5/8kHBK4hEtVApV2naXE6d
         PAOVa/3LB+EbRakpDSP5+Yl0Bj8iuIrvqx5yvsSrnPLbOyRI1oLIQOZVm8CsvzYSLkZ4
         aF7w==
X-Gm-Message-State: AC+VfDxMlU94PFh4lY4awHac2CRJSmRoLCu2okMXlBiJwvuCWK4GDH6L
        /7C+eLrDTnm3702CTwRTPuYD2vlCqViP6gZ6tJ8=
X-Google-Smtp-Source: ACHHUZ4NJQgef5nT4Z3jxZmxleaCikSv6tIBeaJXkxMfQ/O97sFDw1/UnRNbuS/+gtZmvOZlY6994FLcBFPbMTrTVMI=
X-Received: by 2002:aa7:da42:0:b0:510:e80f:fa4e with SMTP id
 w2-20020aa7da42000000b00510e80ffa4emr1741336eds.1.1685697533866; Fri, 02 Jun
 2023 02:18:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:10bc:b0:6b:3f71:39b1 with HTTP; Fri, 2 Jun 2023
 02:18:53 -0700 (PDT)
Reply-To: mrs.sophialorence853@gmail.com
From:   "mrs. sophia lorence" <mrsaichagaddafi222@gmail.com>
Date:   Fri, 2 Jun 2023 02:18:53 -0700
Message-ID: <CAKMfHD7Cubkid22yBW+1ZYCc2oNBXoankwXx_nd=xiGW2uja_g@mail.gmail.com>
Subject: HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:531 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrs.sophialorence853[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrsaichagaddafi222[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsaichagaddafi222[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

HELLO DEAR

I'm a dying woman here in the hospital, I was diagnosed as a Cancer
patient over 2 Years ago. I am a business woman
dealing with Gold Exportation. I Am from Us California
I have a charitable and unfulfillment

project that am about to handover to you, if you are interested please
Reply, hope to hear from you.

Please Reply Me with my private Email for Faster Communication

 mrs.sophialorence853@gmail.com

From mrs.sophia lorence

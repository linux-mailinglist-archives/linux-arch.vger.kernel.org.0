Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA516A9FEB
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 20:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjCCTKz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 14:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCCTKy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 14:10:54 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3302A6CD
        for <linux-arch@vger.kernel.org>; Fri,  3 Mar 2023 11:10:53 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-536cb25982eso59537577b3.13
        for <linux-arch@vger.kernel.org>; Fri, 03 Mar 2023 11:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T/YT8jITLgW7f0YnEkkxDYteBnHJRvTOMarDgnnU8jo=;
        b=WuY/QLQREoCp/b7dqoSCqlvVgqpBWi0Ko+dzNfrCNaK/87QwkNUsRsOt8U8isqCVSF
         Ekrnwo8TSElkla+i92qoKIaEpjWOWlbdrSJEcAgI+zy1yR+k6jo2xX9K0dC9on7jGLNo
         KDxVEE5r2uPBIJT9Ps7Pt6WRtw3dUZCFrZS0E+sXOhxIUSdDc/f9g18boDgZXqgFKzxd
         lCHMhgvNw0qXlzx4KsLjchn+fwxQrUpD/jPPyjrKBEIE5pbfZXGiNvZHVzXIuZ4i6573
         nSZDBbVsh3BlV5MMGzVpumFygM3YGMH1eEGxXhxNiasAwHtuC/ANDzrLWjrE/VE+J46R
         ZNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/YT8jITLgW7f0YnEkkxDYteBnHJRvTOMarDgnnU8jo=;
        b=yRED6jEIN/8SAyZOrZHimltOtjJHUcoHN38N7X34yza4I8uQCHHc/SPGQfOKyQpUl8
         Gxtq3qhq3O0aJcDca7KKExaLBCMkPS/lIEPtts8j0wf4rR+rXjknwTFqKtV6zCa87Nbh
         ifiiqEPcMmRi8m66affV76EM60BI1jIZDnqYCguLjiik9VY1vnB4Bo6CM+/yGTRA8BVa
         YPmtc44EJThc+SFUFC88wsbxjpg75NxOHZmyWHL90glqA8Kg/0SmNDrw/iDQ+Nbr2qZk
         LG9J5SwRxq/YBaxgVJClyKkqsjBg8Wa+1bT5b3eDo0x7UOl1CKTAZ6xgYzqQMo5ZroVI
         YWXw==
X-Gm-Message-State: AO0yUKXtoVy1mvcTqKesG3t5BFxBs/sV8+xYh+bux/TZgzvKy2r1mP2L
        +UMdzJwx3iZ5wmGzYqJu3tTsqnmHgVLifI7m3i8=
X-Google-Smtp-Source: AK7set8o/M5dxwnfP5z7bl1T1WIcTzzyrOVLgCvrtmxDx3XjYZHnm5vNvR28lWRplKILF41Iz9fdK1/tOoNcUr3nG2o=
X-Received: by 2002:a81:ae4a:0:b0:52e:b7cf:4cd1 with SMTP id
 g10-20020a81ae4a000000b0052eb7cf4cd1mr1672650ywk.5.1677870652641; Fri, 03 Mar
 2023 11:10:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:7305:b0:481:c138:1afe with HTTP; Fri, 3 Mar 2023
 11:10:52 -0800 (PST)
Reply-To: clmloans9@gmail.com
From:   MR ANTHONY EDWARD <chrisbonnivier@gmail.com>
Date:   Fri, 3 Mar 2023 19:10:52 +0000
Message-ID: <CABTGJ60CcCYHq8DodzKQS839_j3uRha38z8aKGXAPAno_U9XQQ@mail.gmail.com>
Subject: SCHNELLES DARLEHENSANGEBOT ZU 2%
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5040]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [clmloans9[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [chrisbonnivier[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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

--=20
Ben=C3=B6tigen Sie ein Gesch=C3=A4ftsdarlehen oder ein Darlehen jeglicher A=
rt?
Wenn ja, kontaktieren Sie uns

*Vollst=C3=A4ndiger Name:
* Ben=C3=B6tigte Menge:
*Leihdauer:
*Handy:
*Land:

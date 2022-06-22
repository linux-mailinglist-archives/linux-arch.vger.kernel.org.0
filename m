Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA235547E7
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 14:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355299AbiFVImE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 04:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353090AbiFVImD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 04:42:03 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD9538BE2
        for <linux-arch@vger.kernel.org>; Wed, 22 Jun 2022 01:42:01 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id t1so28974637ybd.2
        for <linux-arch@vger.kernel.org>; Wed, 22 Jun 2022 01:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bI751YOuP98wHh1q4rHO/ASQoCAvLeM/hP1e2c0DqAE=;
        b=PW92l96oeoEpT1EAUChJIpUefAOlfdGxx2THJqipyKJFfYZAdug4cviMGzfbr2HFSK
         xbUxodwg0TsrJj1S7PXXDkVMj4RZgpyeqBFMbjNVVpfKzsezCJcCwoCjGQMYBOErvHzi
         hZeIIqtQisRc7yG4Uqk2hnkMMXm0QH5WZS/p3ekRZKX1J5OK9gFQiks7rPaEwNKYTWVt
         ha92fesQFgpz85HsxfbHzQjF1mQIfuMyYzm/NUOxPljc3hDKqOicczbBEge/LKObxXTr
         azMAWkHUDO78AOcFJIzvmQrMjYAiC7v+/FDMuURGWtqzp/y2+qzyXlFwfW6ip+UuUhwZ
         qOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=bI751YOuP98wHh1q4rHO/ASQoCAvLeM/hP1e2c0DqAE=;
        b=wF4RIT4Xc8oLxObCXNlNWRcVkn31SWFdJmG1GJHTzx57oMQ4ucBrMcUINBWY/5V2ar
         lXsF2Vml5Sq1/QJj/raTicVyPgDZDuGH0lkVgz7anIbU8jvw2SgxMFFGXSdwtKAsrARY
         sJjT6sa2Ev1iham9EV/Lwp/4o6AlVeRddMbzVmA7f2mCVBDuh7r6a4YWGRNJNIrKBl2R
         5abYoMlVna2TWHLTiy97Tn4N5TCx3TXfU/zbwxFjlZkeh0zLosNAPsQqAlM0rhAGCr+9
         F3hZyYTSVCspsPf09cLvH7FbH2UqVn4mI+003S5W3OUSgyH5mSTOUQRSQkWVhQPlV+47
         R8Ww==
X-Gm-Message-State: AJIora9Qlzp2vI64KUM3W4FxzZYGtAZi1fLEfiTP06NJ08V1rS6ngnvG
        crkxH5PCjvRyu1o96mTu3MzdEvCxVBtwvvhXv1o=
X-Google-Smtp-Source: AGRyM1s/z6K5sP7mAFZNxnja4NPgjviMwoLbk3q9DQ9Dt6jXYo6LfMls9oXhYfhdCKGmMPGcwRKKFlUzIwAY3AJ25oI=
X-Received: by 2002:a05:6902:1186:b0:64e:b02c:4f99 with SMTP id
 m6-20020a056902118600b0064eb02c4f99mr2565336ybu.165.1655887320915; Wed, 22
 Jun 2022 01:42:00 -0700 (PDT)
MIME-Version: 1.0
Sender: adonald323@gmail.com
Received: by 2002:a05:7000:c21c:0:0:0:0 with HTTP; Wed, 22 Jun 2022 01:42:00
 -0700 (PDT)
From:   Dina Mckenna <dinamckenna1894@gmail.com>
Date:   Wed, 22 Jun 2022 08:42:00 +0000
X-Google-Sender-Auth: sbsP4j7As7MO-qu3SZcDuQGfgYI
Message-ID: <CANHbP4NwBHLLrewQwWeYFw0RQpEao_AkbFfVkBt4DY-UY3C4_w@mail.gmail.com>
Subject: Please need your urgent assistance,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.4 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b31 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5572]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [adonald323[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [adonald323[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello my dear.,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina. mckenna howley, a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ($ 11,000,000.00, Eleven Million Dollars
).  Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for..

I'm waiting for your immediate reply.

May God Bless you,
Mrs. Dina. Mckenna Howley.

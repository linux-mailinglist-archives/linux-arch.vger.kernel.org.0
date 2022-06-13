Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A43549C62
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 20:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243786AbiFMS5v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jun 2022 14:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244696AbiFMS5O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jun 2022 14:57:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0039C29CA9
        for <linux-arch@vger.kernel.org>; Mon, 13 Jun 2022 09:03:35 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso3346056pjg.1
        for <linux-arch@vger.kernel.org>; Mon, 13 Jun 2022 09:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=gPqm/HENPUr4/IG5FIju+yXQ31rETL85DWSGKXq62SU=;
        b=cVPsBAoxMTeUENPS5CDh9E+a19n9EPjeKyDA8gfZPhyvDoqKH31W9JVKZWOSSath2N
         tT/xiGKHCRbDNq0OIoA3Rd1JBaAU0XEIcgpaoJhYrmiJKILE5PTPC2wC5frpmGC/sV75
         qkpbigTwqNT83655tf+8qWmY83Z1KWOsC5SmHP6gyi0hrK9kSnDmO5AwYHG/C2z5Foqq
         eQ9SgI5L0qoYYRvMVdcunBFTKXdmqVgbOAS5VaS0Vlie73dh1bIyozNDi3Kb4UlzdYed
         n9FLo3cUp2eT5MRKwT0s+pxxzWaSeIHtQi7/Y5pGp1U1lhRAeLidyZTvl3bo3aJ0rvlt
         ngdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=gPqm/HENPUr4/IG5FIju+yXQ31rETL85DWSGKXq62SU=;
        b=Bmv6mYL15+kHHzjNIYBzBSYC0MvHQIxI1Q/Fxngp9SnDssOrd7X/lfj6ViDEPxW6nE
         z5Inqu6ewsU4zPAgAb3eLhwsHKJIG9SJLsuQQ3X/sVmKk4zh1+0zji0Y1Ki7DvvcjROD
         bP9kCwGvSVaTS3w6dH1gbYNAP1BGJgCpjuRpHmEEnsBQJSBlVrpqjlm6zYtnbNqIvyMm
         2P9Xa+gdRYP/my0JdYrCCKdhtbE0KJpAscBy5MSlxZhMhNgtdwaMOCm+1JWDM/GGchh5
         E3D1qKrTnYffH1mPgiU4IiH6VjVyYjnUM3arnT9OLPFhJiRuseGMfcvktlsBAygPT98t
         UFIg==
X-Gm-Message-State: AJIora+qOsqzIH1Z5WCXDSVvzRnoHWWP/Fx2YvQmbSbllcX+akPeELzp
        h+pRiwi7Uze/O8INfsid2jBq5cF6AJbrrcczpSE=
X-Google-Smtp-Source: AGRyM1tCOJ/SzQITiQTpF5e31JJmqAUt9kdJLNWFTj/h4x6VnTUGFVhI8/MkyYjdaAdkJQmKjS1/4KbOqaXHfhT5c3o=
X-Received: by 2002:a17:902:74c3:b0:167:6811:40 with SMTP id
 f3-20020a17090274c300b0016768110040mr358673plt.120.1655136215530; Mon, 13 Jun
 2022 09:03:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:ce97:b0:2a5:a3d4:9ead with HTTP; Mon, 13 Jun 2022
 09:03:34 -0700 (PDT)
Reply-To: drwarren.e.buffettfoundations@gmail.com
From:   "Dr. Warren Edward Buffett" <abdullahiauwal001@gmail.com>
Date:   Mon, 13 Jun 2022 17:03:34 +0100
Message-ID: <CALNO1vY37bDayQdZ-EOOXwCK+Ux18sAoSDrsyZJSUMmjkDTz-w@mail.gmail.com>
Subject: Spende
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1043 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8947]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [abdullahiauwal001[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [abdullahiauwal001[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--=20
Gr=C3=BC=C3=9Fe

Herzlichen Gl=C3=BCckwunsch, Dies ist Dr. Warren Edward Buffett, ein
amerikanischer Wirtschaftsmagnat, Investor und Philanthrop.
Erfreuliche Nachrichten vom Chairman und CEO von Berkshire Hathaway.
Ich habe 25 Prozent meines pers=C3=B6nlichen Verm=C3=B6gens daf=C3=BCr ausg=
egeben.
Wohlt=C3=A4tigkeit? Ich leite derzeit die (Letters Foundation) und habe den
Rest meines 25-Prozent-Einkommens versprochen, indem ich 17,5
Milliarden US-Dollar online an 60 gl=C3=BCckliche Menschen auf der ganzen
Welt spende.

Der Auswahlprozess erfolgte jedoch stichprobenartig Auswahl in unserer
computergest=C3=BCtzten E-Mail-Auswahlmaschine aus einer Datenbank aus =C3=
=BCber
250.000 E-Mail-Adressen aus allen Kontinenten weltweit. M=C3=B6glicherweise
wurden Sie als gl=C3=BCcklicher Partner ausgew=C3=A4hlt und erhalten eine
Entsch=C3=A4digung von (3,5 Millionen Euro). Bitte f=C3=BCllen Sie die folg=
enden
Informationen aus, wenn Sie an meiner Spende interessiert sind. Bitte
kontaktieren Sie meinen pers=C3=B6nlichen Assistenten f=C3=BCr weitere
Informationen mit Ihren korrekten Informationen. Bitte kontaktieren
Sie die untenstehende E-Mail, um Ihr Geld zu erhalten
(drwarren.e.buffettfoundations@gmail.com).

Hier sind die Informationen, die Sie ben=C3=B6tigen.

Vollst=C3=A4ndiger Name:
Land:
Bundesland / Stadt:
Das Alter:
Beruf / Arbeit:
Handy Nummer:
Adresse:

Kontakt-E-Mail: drwarren.e.buffettfoundations@gmail.com

Mit freundlichen Gr=C3=BC=C3=9Fe
Dr. Warren Buffett

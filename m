Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E20682DF6
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 14:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjAaNcd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 08:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjAaNcb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 08:32:31 -0500
Received: from mx-gw-prx01.wika.co.id (pegasus.wika.zone [103.25.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 169914FC36;
        Tue, 31 Jan 2023 05:32:28 -0800 (PST)
Received: from mx-gw-prx01.wika.co.id (localhost.localdomain [127.0.0.1])
        by mx-gw-prx01.wika.co.id (Proxmox) with ESMTP id DB7B743A9B;
        Tue, 31 Jan 2023 20:32:27 +0700 (WIB)
Received: from smtp-gw.wika.co.id (smtp-gw.wika.co.id [10.4.0.44])
        by mx-gw-prx01.wika.co.id (Proxmox) with ESMTP id 0CF8043A86;
        Tue, 31 Jan 2023 20:32:27 +0700 (WIB)
Received: from smtp-gw-01.wika.co.id (localhost [127.0.0.1])
        by smtp-gw1.wika.co.id (Postfix) with ESMTP id 7C78C1E0EB;
        Tue, 31 Jan 2023 20:32:11 +0700 (WIB)
X-Virus-Scanned: amavisd-new at wika.co.id
Received: from smtp-gw.wika.co.id ([127.0.0.1])
        by smtp-gw-01.wika.co.id (smtp-gw-01.wika.co.id [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yydppp39sFnL; Tue, 31 Jan 2023 20:32:11 +0700 (WIB)
Received: from mailbox.wika.co.id (unknown [10.4.0.84])
        by smtp-gw1.wika.co.id (Postfix) with ESMTP id DB7621DF29;
        Tue, 31 Jan 2023 20:31:55 +0700 (WIB)
Received: from localhost (localhost [127.0.0.1])
        by mailbox.wika.co.id (Postfix) with ESMTP id 52FB37FD2EBD1;
        Tue, 31 Jan 2023 20:31:59 +0700 (WIB)
Received: from mailbox.wika.co.id ([127.0.0.1])
        by localhost (mailbox.wika.co.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8-G872VGh5kJ; Tue, 31 Jan 2023 20:31:58 +0700 (WIB)
Received: from localhost (localhost [127.0.0.1])
        by mailbox.wika.co.id (Postfix) with ESMTP id A86117FD2EBC9;
        Tue, 31 Jan 2023 20:31:56 +0700 (WIB)
DKIM-Filter: OpenDKIM Filter v2.10.3 mailbox.wika.co.id A86117FD2EBC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wika.co.id;
        s=3A269092-2A4A-11ED-99C4-3E27D2C9E2D5; t=1675171917;
        bh=tPFCCctfbSn+qtCDcB5loatRX7+/l2Bj4wKC8R+HD54=;
        h=Date:From:Message-ID:MIME-Version;
        b=P5mFnunkjVKLhyYltMg7K9NVGb8GSPOUAI8Wdg2j/DYdLDUiPnddCCdNShvdxBom7
         54jq3MVD8rZAfizRqq4MtyX1vWXwD6QW8h46XawJ1KPWrsC2ZMX1FwRZEBni/kLnZj
         mXTlV9v+ovfakmneRvUF2VHqjBqbBubOR+1rWqz2HLL2FrLkKMknv/zGNOAA3Bn52W
         YDu3OUa2OUyz21B1TSsPjS1abq+ssHqCbZ9ntNYFqXex4K8siq3YOFTe72NsYbrXqs
         7hSVyWV9IP+svUsjOjenjMV9U0TdzezX4DeegyqD3FWMRdi81qeSWZz4yhgLfSSu4I
         /6cRLeMFs30fg==
X-Virus-Scanned: amavisd-new at wika.co.id
Received: from mailbox.wika.co.id ([127.0.0.1])
        by localhost (mailbox.wika.co.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bUJj_hL6FQkG; Tue, 31 Jan 2023 20:31:56 +0700 (WIB)
Received: from mailbox.wika.co.id (mailbox.wika.co.id [10.5.0.1])
        by mailbox.wika.co.id (Postfix) with ESMTP id 69F5B7FD5D2AF;
        Tue, 31 Jan 2023 20:31:15 +0700 (WIB)
Date:   Tue, 31 Jan 2023 20:31:15 +0700 (WIB)
From:   =?utf-8?B?0YHQuNGB0YLQtdC80L3QuNC5INCw0LTQvNGW0L3RltGB0YLRgNCw0YLQvtGA?= 
        <wellbeing@wika.co.id>
Reply-To: sistemassadmins@mail2engineer.com
Message-ID: <58950367.80236.1675171875031.JavaMail.zimbra@wika.co.id>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Originating-IP: [10.5.0.1]
X-Mailer: Zimbra 8.8.12_GA_3866 (zclient/8.8.12_GA_3866)
Thread-Index: CLGokQ3VpdnKwmH4TFyoMJ/kgnr9gg==
Thread-Topic: 
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        MISSING_HEADERS,REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

=D1=83=D0=B2=D0=B0=D0=B3=D0=B0;

=D0=92=D0=B0=D1=88=D0=B0 =D0=B5=D0=BB=D0=B5=D0=BA=D1=82=D1=80=D0=BE=D0=BD=
=D0=BD=D0=B0 =D0=BF=D0=BE=D1=88=D1=82=D0=B0 =D0=BF=D0=B5=D1=80=D0=B5=D0=B2=
=D0=B8=D1=89=D0=B8=D0=BB=D0=B0 =D0=BE=D0=B1=D0=BC=D0=B5=D0=B6=D0=B5=D0=BD=
=D0=BD=D1=8F =D0=BF=D0=B0=D0=BC'=D1=8F=D1=82=D1=96, =D1=8F=D0=BA=D0=B5 =D1=
=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C 5 =D0=93=D0=91, =D0=B2=
=D0=B8=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D0=B5 =D0=B0=D0=B4=D0=BC=D1=96=
=D0=BD=D1=96=D1=81=D1=82=D1=80=D0=B0=D1=82=D0=BE=D1=80=D0=BE=D0=BC, =D1=8F=
=D0=BA=D0=B5 =D0=B2 =D0=B4=D0=B0=D0=BD=D0=B8=D0=B9 =D1=87=D0=B0=D1=81 =D0=
=BF=D1=80=D0=B0=D1=86=D1=8E=D1=94 =D0=BD=D0=B0 10,9 =D0=93=D0=91. =D0=92=D0=
=B8 =D0=BD=D0=B5 =D0=B7=D0=BC=D0=BE=D0=B6=D0=B5=D1=82=D0=B5 =D0=BD=D0=B0=D0=
=B4=D1=81=D0=B8=D0=BB=D0=B0=D1=82=D0=B8 =D0=B0=D0=B1=D0=BE =D0=BE=D1=82=D1=
=80=D0=B8=D0=BC=D1=83=D0=B2=D0=B0=D1=82=D0=B8 =D0=BD=D0=BE=D0=B2=D1=83 =D0=
=BF=D0=BE=D1=88=D1=82=D1=83, =D0=B4=D0=BE=D0=BA=D0=B8 =D0=BD=D0=B5 =D0=BF=
=D0=B5=D1=80=D0=B5=D0=B2=D1=96=D1=80=D0=B8=D1=82=D0=B5 =D0=BF=D0=BE=D1=88=
=D1=82=D0=BE=D0=B2=D1=83 =D1=81=D0=BA=D1=80=D0=B8=D0=BD=D1=8C=D0=BA=D1=83=
 "=D0=92=D1=85=D1=96=D0=B4=D0=BD=D1=96". =D0=A9=D0=BE=D0=B1 =D0=B2=D1=96=D0=
=B4=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D0=B8 =D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=
=BD=D1=96=D1=81=D1=82=D1=8C =D0=BF=D0=BE=D1=88=D1=82=D0=BE=D0=B2=D0=BE=D1=
=97 =D1=81=D0=BA=D1=80=D0=B8=D0=BD=D1=8C=D0=BA=D0=B8, =D0=BD=D0=B0=D0=B4=D1=
=96=D1=88=D0=BB=D1=96=D1=82=D1=8C =D1=82=D0=B0=D0=BA=D1=96 =D0=B2=D1=96=D0=
=B4=D0=BE=D0=BC=D0=BE=D1=81=D1=82=D1=96
=D0=BD=D0=B8=D0=B6=D1=87=D0=B5:

=D0=86=D0=BC'=D1=8F:
=D0=86=D0=BC'=D1=8F =D0=BA=D0=BE=D1=80=D0=B8=D1=81=D1=82=D1=83=D0=B2=D0=B0=
=D1=87=D0=B0:
=D0=BF=D0=B0=D1=80=D0=BE=D0=BB=D1=8C:
=D0=9F=D1=96=D0=B4=D1=82=D0=B2=D0=B5=D1=80=D0=B4=D0=B6=D0=B5=D0=BD=D0=BD=D1=
=8F =D0=BF=D0=B0=D1=80=D0=BE=D0=BB=D1=8F:
=D0=90=D0=B4=D1=80=D0=B5=D1=81=D0=B0 =D0=B5=D0=BB=D0=B5=D0=BA=D1=82=D1=80=
=D0=BE=D0=BD=D0=BD=D0=BE=D1=97 =D0=BF=D0=BE=D1=88=D1=82=D0=B8:
=D1=82=D0=B5=D0=BB=D0=B5=D1=84=D0=BE=D0=BD:

=D0=AF=D0=BA=D1=89=D0=BE =D0=BD=D0=B5 =D0=B2=D0=B4=D0=B0=D1=94=D1=82=D1=8C=
=D1=81=D1=8F =D0=BF=D0=BE=D0=B2=D1=82=D0=BE=D1=80=D0=BD=D0=BE =D0=BF=D0=B5=
=D1=80=D0=B5=D0=B2=D1=96=D1=80=D0=B8=D1=82=D0=B8 =D0=BF=D0=BE=D0=B2=D1=96=
=D0=B4=D0=BE=D0=BC=D0=BB=D0=B5=D0=BD=D0=BD=D1=8F, =D0=B2=D0=B0=D1=88=D0=B0=
 =D0=BF=D0=BE=D1=88=D1=82=D0=BE=D0=B2=D0=B0 =D1=81=D0=BA=D1=80=D0=B8=D0=BD=
=D1=8C=D0=BA=D0=B0 =D0=B1=D1=83=D0=B4=D0=B5 =D0=92=D0=B8=D0=BC=D0=BA=D0=BD=
=D1=83=D1=82=D0=BE!

=D0=9F=D1=80=D0=B8=D0=BD=D0=BE=D1=81=D0=B8=D0=BC=D0=BE =D0=B2=D0=B8=D0=B1=
=D0=B0=D1=87=D0=B5=D0=BD=D0=BD=D1=8F =D0=B7=D0=B0 =D0=BD=D0=B5=D0=B7=D1=80=
=D1=83=D1=87=D0=BD=D0=BE=D1=81=D1=82=D1=96.
=D0=9A=D0=BE=D0=B4 =D0=BF=D1=96=D0=B4=D1=82=D0=B2=D0=B5=D1=80=D0=B4=D0=B6=
=D0=B5=D0=BD=D0=BD=D1=8F: UA:@UA.WEB.ADMIN.WEBUR431MeP453.UA
=D0=A2=D0=B5=D1=85=D0=BD=D1=96=D1=87=D0=BD=D0=B0 =D0=BF=D1=96=D0=B4=D1=82=
=D1=80=D0=B8=D0=BC=D0=BA=D0=B0 =D0=9F=D0=BE=D1=88=D1=82=D0=B8 =D0=A1=D0=B8=
=D1=81=D1=82=D0=B5=D0=BC=D0=BD=D0=B8=D0=B9 =D0=B0=D0=B4=D0=BC=D1=96=D0=BD=
=D1=96=D1=81=D1=82=D1=80=D0=B0=D1=82=D0=BE=D1=80 =C2=A9 2023


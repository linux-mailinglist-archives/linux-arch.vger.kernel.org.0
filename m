Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600E7675019
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 10:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjATJDp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 04:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjATJDp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 04:03:45 -0500
X-Greylist: delayed 383 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Jan 2023 01:03:39 PST
Received: from mx-gw-prx01.wika.co.id (pegasus.wika.zone [103.25.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26A8363E12;
        Fri, 20 Jan 2023 01:03:38 -0800 (PST)
Received: from mx-gw-prx01.wika.co.id (localhost.localdomain [127.0.0.1])
        by mx-gw-prx01.wika.co.id (Proxmox) with ESMTP id BA93142F16;
        Fri, 20 Jan 2023 15:57:10 +0700 (WIB)
Received: from smtp-gw.wika.co.id (smtp-gw.wika.co.id [10.4.0.44])
        by mx-gw-prx01.wika.co.id (Proxmox) with ESMTP id DD7F742F99;
        Fri, 20 Jan 2023 15:57:09 +0700 (WIB)
Received: from smtp-gw-01.wika.co.id (localhost [127.0.0.1])
        by smtp-gw1.wika.co.id (Postfix) with ESMTP id DFA461C70B;
        Fri, 20 Jan 2023 15:56:57 +0700 (WIB)
X-Virus-Scanned: amavisd-new at wika.co.id
Received: from smtp-gw.wika.co.id ([127.0.0.1])
        by smtp-gw-01.wika.co.id (smtp-gw-01.wika.co.id [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SpKhbJbklYDz; Fri, 20 Jan 2023 15:56:57 +0700 (WIB)
Received: from mailbox.wika.co.id (unknown [10.4.0.84])
        by smtp-gw1.wika.co.id (Postfix) with ESMTP id A524D1C615;
        Fri, 20 Jan 2023 15:56:44 +0700 (WIB)
Received: from localhost (localhost [127.0.0.1])
        by mailbox.wika.co.id (Postfix) with ESMTP id 70B057FD286A0;
        Fri, 20 Jan 2023 15:56:47 +0700 (WIB)
Received: from mailbox.wika.co.id ([127.0.0.1])
        by localhost (mailbox.wika.co.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id J9dIqoPOE9sU; Fri, 20 Jan 2023 15:56:47 +0700 (WIB)
Received: from localhost (localhost [127.0.0.1])
        by mailbox.wika.co.id (Postfix) with ESMTP id 0A0AE7FD2869D;
        Fri, 20 Jan 2023 15:56:45 +0700 (WIB)
DKIM-Filter: OpenDKIM Filter v2.10.3 mailbox.wika.co.id 0A0AE7FD2869D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wika.co.id;
        s=3A269092-2A4A-11ED-99C4-3E27D2C9E2D5; t=1674205006;
        bh=tPFCCctfbSn+qtCDcB5loatRX7+/l2Bj4wKC8R+HD54=;
        h=Date:From:Message-ID:MIME-Version;
        b=QDLKi+s7OsK1C00EZ4Axx8OpFaduh7jQ5eLvdyRnN98rdOrOXxUd+cb5Ck92BekEC
         BYavigWMe5Cds5HILMAvJszNIX42uAKc1RB6ha/GbQxjzKd54lOan15N86Rgbo+TFN
         GZ4MGtIktghN4sTPkCugVvlT+zRiwKOD1NnYTFSxYX0hcPpS3vxKLJ2RC0Lpya7TD1
         pJyHxFAA/yb2bHShYKJHQsDRHnDbPseKMbYPJdMzl12EF80upzN5TImo6flR0OWJk5
         j852BE55vS0jISRaw+6iRcff6HdlP1bdQOoHjcJitcZOnpEFzEIVBX0X5w2autV8PU
         IPq2eX4NEUBtw==
X-Virus-Scanned: amavisd-new at wika.co.id
Received: from mailbox.wika.co.id ([127.0.0.1])
        by localhost (mailbox.wika.co.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nI7arVTNRxNN; Fri, 20 Jan 2023 15:56:45 +0700 (WIB)
Received: from mailbox.wika.co.id (mailbox.wika.co.id [10.5.0.1])
        by mailbox.wika.co.id (Postfix) with ESMTP id 894687FD47E0D;
        Fri, 20 Jan 2023 15:55:47 +0700 (WIB)
Date:   Fri, 20 Jan 2023 15:55:47 +0700 (WIB)
From:   =?utf-8?B?0YHQuNGB0YLQtdC80L3QuNC5INCw0LTQvNGW0L3RltGB0YLRgNCw0YLQvtGA?= 
        <wellbeing@wika.co.id>
Reply-To: sistemassadmins@mail2engineer.com
Message-ID: <375708616.1298982.1674204947188.JavaMail.zimbra@wika.co.id>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Originating-IP: [10.5.0.1]
X-Mailer: Zimbra 8.8.12_GA_3866 (zclient/8.8.12_GA_3866)
Thread-Index: x+Z/i56zogopmv6iI4FWAwotc8vaAQ==
Thread-Topic: 
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        MISSING_HEADERS,REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4815]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.0 MISSING_HEADERS Missing To: header
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  1.6 REPLYTO_WITHOUT_TO_CC No description available.
        *  0.0 UPPERCASE_50_75 message body is 50-75% uppercase
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
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


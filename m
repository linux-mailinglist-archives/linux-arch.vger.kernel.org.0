Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62715588AAF
	for <lists+linux-arch@lfdr.de>; Wed,  3 Aug 2022 12:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiHCKjc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Aug 2022 06:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiHCKjb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Aug 2022 06:39:31 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9D1E0EF
        for <linux-arch@vger.kernel.org>; Wed,  3 Aug 2022 03:39:30 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x39so16208681lfu.7
        for <linux-arch@vger.kernel.org>; Wed, 03 Aug 2022 03:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=9Q86IpDBWLEP7oSSTnvQ9orLNIQkjNwJszaZE/TDKss=;
        b=JVHtIyYq3jeEkgoqpylqzvonldqjXqV0z38vf3CXW0vhvzqNewSMUA7l9AiNmyPQNX
         Iwmtu5Y9VGvFardbh0JAbs9RXROpaO7/H26gPoAhfetCz/zg7dhn3qFRALiTgI2HZipo
         d4HEqrJi4770nYfu0uOXIMnrobrdO2I99ATfBdk73lk+gYrV3liZgxdbVN7lLDD38HYp
         va5C2MnWf9HQRjLlvFEK60AiZFaVj8rca5NWet0ZW8Xdg+15CuvZCAzB/FcVWla3s8Ef
         SMYiJF+j3KAJfSmck2TZIH6IdXdCa/uLedPyk+t8pHRrG4IOZC2nkpibldoiT5MbqIMo
         VGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9Q86IpDBWLEP7oSSTnvQ9orLNIQkjNwJszaZE/TDKss=;
        b=0ryTw8rNHysXMvH75E4tpsJVBWGobRvx3jShPJjaivB617UIZLx+Q8GxDMiAlRARuw
         c3mn1JAYPvDUuWkF5ZL9jy9CF9gFbSoqhRFiZUA4V5jcBAam8NAy1D/FeEiIEXl6kQB3
         zo64q/bMCCSHkxWsVUIuwjmWW6Vmlsx7loRX9WCOdqmI1jYwzunnVMDdmvjwhZfR4NHr
         QsFlpExhZqf25RKh/+m9M/Pl/QD1P+hNkZ9eJENdZAV+eJHSK91uei3X+xb18etDqMcC
         QrA6Jg7RA+mqRl7TzkBuj9zsr0LwhRunxQ6+oAmJ2GWLj5TCDT7thDqCvA/fEVzTKTuB
         WnqA==
X-Gm-Message-State: ACgBeo2B/CPnZzU6I8O7F3hdI67+jEc8Va0QT0nEo9l3udzS1TwT4dON
        ylr0xFiHBTZOzMwye5OihgJKCVoKxDMWr2WBpKU=
X-Google-Smtp-Source: AA6agR40TisgFZndY4SAvA+BSx1WoUPmwri028yLGF/en1iJllpE7y74IyyZudQikNSafVesOsUsgq9cEkW8fuHJuZY=
X-Received: by 2002:ac2:4c82:0:b0:48b:23:726b with SMTP id d2-20020ac24c82000000b0048b0023726bmr4016821lfl.24.1659523168941;
 Wed, 03 Aug 2022 03:39:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:6309:0:0:0:0:0 with HTTP; Wed, 3 Aug 2022 03:39:28 -0700 (PDT)
Reply-To: OLSONFINANCIAL.DE@gmail.com
From:   OLSON FINANCIAL GROUP <amadip120@gmail.com>
Date:   Wed, 3 Aug 2022 03:39:28 -0700
Message-ID: <CAHb0K2Epmik0znhGY4k5inV8Ucn=6X-J-DVM6Y+rHGrT3YqZhQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:143 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [amadip120[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [amadip120[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--=20
Hallo guten Morgen,
Ben=C3=B6tigen Sie dringend einen Kredit f=C3=BCr den Hauskauf? oder ben=C3=
=B6tigen
Sie ein Gesch=C3=A4fts- oder Privatdarlehen, um zu investieren? ein neues
Gesch=C3=A4ft er=C3=B6ffnen, Rechnungen bezahlen? Und zahlen Sie uns
Installationen zur=C3=BCck? Wir sind ein zertifiziertes Finanzunternehmen.
Wir bieten Privatpersonen und Unternehmen Kredite an. Wir bieten
zuverl=C3=A4ssige Kredite zu einem sehr niedrigen Zinssatz von 2 %. F=C3=BC=
r
weitere Informationen
mailen Sie uns an: olsonfinancial.de@gmail.com......

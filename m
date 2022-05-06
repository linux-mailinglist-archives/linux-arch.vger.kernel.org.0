Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B2651D5D4
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 12:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391028AbiEFKlE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 06:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343916AbiEFKlD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 06:41:03 -0400
X-Greylist: delayed 941 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 03:37:17 PDT
Received: from spf27.trabajo.gob.ec (spf27.trabajo.gob.ec [190.152.44.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BF8689AD
        for <linux-arch@vger.kernel.org>; Fri,  6 May 2022 03:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=trabajo.gob.ec; s=trabajo;
        h=Message-Id:Reply-To:Date:From:To:Subject:Content-Description:Content-Transfer-Encoding:MIME-Version:Content-Type; bh=1yRzq0DZsIZjcXwAKrsL0IEgLapFOXBvt5L3aNoafiE=;
        b=cAifkKeYD+R95rnBCimonEKtdc2wKMIwo/esHpjXkOSbjOARHO1gC3dx86NHWA4c0cxoAWzHSzdGpWPsz0/l96boTh5PfSgE90BWe5U0rvCWCRl96ITazJKHezLoxPXZnQA1BXFgxRaHMGb0ChxL9phm1yrU6LIRimWB6SoIsbY=;
Received: from master4.trabajo.gob.ec ([192.168.198.154])
        by spf27.trabajo.gob.ec with esmtps (UNKNOWN:AES256-GCM-SHA384:256)
        (Exim 4.76)
        (envelope-from <karla_lascano@trabajo.gob.ec>)
        id 1nmv57-000AeO-9j; Fri, 06 May 2022 05:21:10 -0500
Received: from master4.trabajo.gob.ec ([192.168.198.154] helo=localhost)
        by master4.trabajo.gob.ec with esmtp (Exim 4.76)
        (envelope-from <karla_lascano@trabajo.gob.ec>)
        id 1nmv1k-000AZz-9L; Fri, 06 May 2022 05:17:36 -0500
X-Quarantine-ID: <Gl2KNgpdybh3>
Received: from atmailing.trabajo.gob.ec ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (minspectord-new, port 10024)
        with ESMTP id Gl2KNgpdybh3; Fri,  6 May 2022 05:17:36 -0500 (-05)
Received: from [192.168.1.127] (helo=webmail.trabajo.gob.ec)
        by atmailing.trabajo.gob.ec with smtp (Exim 4.76)
        (envelope-from <karla_lascano@trabajo.gob.ec>)
        id 1nmuqL-0003zr-La; Fri, 06 May 2022 05:05:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by webmail.trabajo.gob.ec (Postfix) with ESMTP id 5B4FCE0801;
        Fri,  6 May 2022 05:02:38 -0500 (ECT)
Received: from webmail.trabajo.gob.ec ([127.0.0.1])
        by localhost (webmail.trabajo.gob.ec [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wymGaZInoEp0; Fri,  6 May 2022 05:02:38 -0500 (ECT)
Received: from webmail.trabajo.gob.ec (localhost [127.0.0.1])
        by webmail.trabajo.gob.ec (Postfix) with ESMTP id 9E638E0AC7;
        Fri,  6 May 2022 04:57:43 -0500 (ECT)
Received: from [10.13.18.7] (unknown [156.146.63.14])
        by webmail.trabajo.gob.ec (Postfix) with ESMTPSA id 99EC7E0BAC;
        Fri,  6 May 2022 04:56:58 -0500 (ECT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: OFFER
To:     Recipients <karla_lascano@trabajo.gob.ec>
From:   Susanne Klatten <karla_lascano@trabajo.gob.ec>
Date:   Fri, 06 May 2022 17:53:40 +0800
Reply-To: susanne.klatten212@gmail.com
Message-Id: <20220506095659.99EC7E0BAC@webmail.trabajo.gob.ec>
X-RCPTControl: Supera
X-CantidadCopias: 180
X_SOURCE_IP: 192.168.1.127
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [susanne.klatten212[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello

I'm Susanne Klatten and I am  From Germany, I can control your financial pr=
oblems without resorting Banks in the range of Credit Money . We offer pers=
onal Loans and Business Loan, i am an approved and certified lender with ye=
ars of experience in Loan lending and we give out Collateral and Non Collat=
eral Loan amounts ranging from 10,000.00=E2=82=AC ( $)  to the maximum of 5=
00,000,000.00=E2=82=AC  with a fixed interest of 3% on an  annual basis. Do=
 you need a Loan?   Email us at:  susanne.klatten212@gmail.com

You can also view my link and learn more about me.

https://en.wikipedia.org/wiki/Susanne_Klatten
https://www.forbes.com/profile/susanne-klatten

Email :  susanne.klatten212@gmail.com
Signature,
Executive Chairman
Susanne Klatten.






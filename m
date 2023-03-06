Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EF96ABA1D
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 10:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCFJkl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 04:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjCFJkk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 04:40:40 -0500
X-Greylist: delayed 1184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Mar 2023 01:40:38 PST
Received: from mail.ettrick.pl (mail.ettrick.pl [141.94.21.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EF7211DE
        for <linux-arch@vger.kernel.org>; Mon,  6 Mar 2023 01:40:38 -0800 (PST)
Received: by mail.ettrick.pl (Postfix, from userid 1002)
        id 44897A4E17; Mon,  6 Mar 2023 09:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ettrick.pl; s=mail;
        t=1678093404; bh=KHux3km3Civcx5ChslOYQZwQRBjoJa4kWJfGcMIuN6w=;
        h=Date:From:To:Subject:From;
        b=MYG+nIS2UYNLX6zOxzyfxirz2AOrf/nFvTs0jhn7s/1BALervWaFHPzZn8pR4zSSo
         p0J4vgqAuMFpIwHhJnwYJPHCS8cy9SFx+y9vu7s6ONZJmZ6/qHwulG0dCqQSD9B2K6
         9iOxAMJgfL/zvjGwLBYDX92OTQy4/m6IJWGU3KEEKSQ6Pw1k3KnTLrn6vYHVPlZkZ9
         O5mDQ4vy1IrhMmpJagbXrXwzv/j/74m091o0pCfPnJigj3+oHsVaPSg4apCDyYlW+B
         Dx4d6Y/TI0us12JuFemo/Jn2oJXJX0TAmJY7K5ZsK0uUsFZqsd/syhuQ3n8z7aEokM
         zmJcbGF07AGzw==
Received: by mail.ettrick.pl for <linux-arch@vger.kernel.org>; Mon,  6 Mar 2023 09:00:53 GMT
Message-ID: <20230306074500-0.1.97.36zaa.0.jxxk9hmi27@ettrick.pl>
Date:   Mon,  6 Mar 2023 09:00:53 GMT
From:   "Norbert Karecki" <norbert.karecki@ettrick.pl>
To:     <linux-arch@vger.kernel.org>
Subject: Fotowoltaika - nowe warunki
X-Mailer: mail.ettrick.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,URIBL_ABUSE_SURBL,URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: ettrick.pl]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [141.94.21.111 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: ettrick.pl]
        * -0.5 BAYES_05 BODY: Bayes spam probability is 1 to 5%
        *      [score: 0.0141]
        *  1.2 URIBL_ABUSE_SURBL Contains an URL listed in the ABUSE SURBL
        *      blocklist
        *      [URIs: ettrick.pl]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dzie=C5=84 dobry,

chcia=C5=82bym poinformowa=C4=87, i=C5=BC mog=C4=85 Pa=C5=84stwo uzyska=C4=
=87 dofinansowanie na systemy fotowoltaiczne w ramach nowej edycji progra=
mu M=C3=B3j Pr=C4=85d.

Program zapewnia 6000 z=C5=82 dofinansowania na instalacj=C4=99 paneli i =
16 000 z=C5=82 na magazyn energii, ni=C5=BCsze cen pr=C4=85du i mo=C5=BCl=
iwo=C5=9B=C4=87 odliczenia koszt=C3=B3w zwi=C4=85zanych z instalacj=C4=85=
 fotowoltaiki w ramach rozliczenia PIT (tzw. ulga termomodernizacyjna).

Czy s=C4=85 Pa=C5=84stwo otwarci na wst=C4=99pn=C4=85 rozmow=C4=99 w tym =
temacie?


Pozdrawiam,
Norbert Karecki

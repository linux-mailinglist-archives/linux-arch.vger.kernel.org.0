Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7DC21483B
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jul 2020 20:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgGDS7h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Jul 2020 14:59:37 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com ([77.238.176.99]:34847
        "EHLO sonic301-22.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726922AbgGDS7g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Jul 2020 14:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1593889173; bh=ZWeDLwf4cGlLDzTwCuOen1zTINlp5j+f2ywobrqBR9o=; h=Date:From:Reply-To:Subject:References:From:Subject; b=ntJ3spp+PoyEufaAOy2iW+jZu8FjLflwsAbkW49Qn/h6B+G4jpxCm2Q7yTkHlwmj1+djSm4jourWfpaVKO+z3eKjTAeRgqAX+3ePyVMePYODmzex4gAxs2vkpeyX9Q9o6PenuPgxZvo/JDGqw6S/H3ggH6feTVsrrEksa5WHxo9nDzK9m/UsRx3Ecwwl+MwCKjtrrlYHVmM71soyds9gHUzg3lfxWRQ5TwGQOohgGKQAEYs37LFlzt0GoW2QVI677ic17Q8DbUXUV+PdmjiuBBivQrVYzDtGFfrDge39KeuqNXDi30fHLO1Xj9VPPnpxoXsR3xZ81RPmDZJcYj1lNg==
X-YMail-OSG: IEXMUeAVM1m1gPtltFK.fyn.DxvmXyKwB4p72nQRIEpIBUINTRsbraNT_NxPQj0
 5DRBSoij_Pj6y6dGMJPIMCI.RKchAVBEhdeA.3Xhkllqho0W6t5WEubdtOtqxn6lcwOZMTSHAB54
 aPqsiAG9YwGDHoigR7gj1PrRVsR7ImQIcuPOyHn81qTVWFm4DXqi4Tm8mXYqdLN.DITlW1wmexaL
 PZp6vj9YP2p_SlToPg.0D5GCUOX008lrZis7ubQqtPz9VO.1EwFDpRm2Gv6N.nvmUl5wJHOreagz
 vMoAfblCzDzUej4rQhLxJbBv_7haeT7BpOFMvtcyX43OCbZHTFETn5ojAjQShP7fwFik4S_6Cyft
 ASvjVes9FBdPLMpvQs1NSk8TlTUMsshDAPkGEui1A.XlzsVJrURRdMBm0Fmnr2xQlrSQqd5oAsp3
 .Nm.IGHrSMzWNuh.3Re39dAh41jJYhQKHqqA8Ftx925Z3IDrT8ZurUzLKZsr2GL.2aivMGFvg32p
 eS8Uw43r4Ip3GT3xJSmKkEAq8rqJ_up.gvl7qvofFGw0CFyKf8uVCjqiUV1j1hlwPBiTwYSXMrwJ
 53oYa3ZsoxTjD2Cilkcujz4pfzcuh80MBQYUFPt3AITD.xhLov_1_QJL3pIsseJCTcW9XqJA.42p
 nquUKQUQ.8OvlZCOZfygX.Ociwo5YoEq1hpMri.O7TpxI2jvcKp0wnZAm8XWIhQyjnWAUb2Ooy_i
 bFlrRPIOrB9kJnB1dFcHyJhGDEP2syFAO8Usi5NJvKnF16QSGWzuN_kJyasDnHEyDXTiHqkhaC1P
 5qVJ3L..jirVyLSb5fVnCNqyY3eGep8yfLhjAgmAlZ6UM2QJ3Nv8RO2n5CpmMf7Dsx6TtzjxvK.z
 uI3X7EIIU.9ENINcSsPLpvfUMCarvbjYQHuKWHP.WUFwU_9wwZU8iwqrzishROiPWT4h1tBBQw.V
 _y2Fnm1VmvYqOsO_j1ZvMgA5bJ8IbMuY8H0ub64ZaMXOR6gY7vYuW74whzROrbhPQnNRifncTqiy
 TuLgBAY68zL3J90BvLcNbmE7UxH4rtvm9uqy.9fpxKmu0C.edDz1aQs3GLsM8f2Ss0FBb9xHKvD1
 B293W_SxVy9OyyQ9OSDZrgcq.JGQp0qfxNP5wAg4iBmLQgBSzW4jX6atrYU.V_QSRsniM7QAY5Jj
 MBJJp9vIlpU3BJXuREpbeYP7D6giGBqoTTaStb7fj6EPSlGdOs1nEl22CdoSkXV7xkecmNPiKy1R
 YGZAvAquBLm3PUPfOK7y2JuBI4dSQsGp2txWkRmoFFLbGN6DUVGFDBbiZoZ91Tl.LDRI9sYituqW
 w
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Sat, 4 Jul 2020 18:59:33 +0000
Date:   Sat, 4 Jul 2020 18:59:30 +0000 (UTC)
From:   Theresa Han <serena@lantermo.it>
Reply-To: theresahan21@hotmail.com
Message-ID: <1469227910.4479605.1593889170815@mail.yahoo.com>
Subject: =?UTF-8?Q?Ich_gr=C3=BC=C3=9Fe_dich_im_Namen_des_Herrn?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1469227910.4479605.1593889170815.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16197 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Ich gr=C3=BC=C3=9Fe dich im Namen des Herrn

Ich kann mir nicht vorstellen wie du dich f=C3=BChlen wirst Sie einen pl=C3=
=B6tzlichen Brief aus einem abgelegenen Land in der fernen Elfenbeink=C3=BC=
ste erhalten werden und wahrscheinlich von jemandem, mit dem Sie nicht gut =
verwandt sind. Ich appelliere an Sie, etwas Geduld zu =C3=BCben und meinen =
Brief zu lesen Umgang mit Ihnen in dieser wichtigen Transaktion
=20
Ich bin Frau Theresa Han, 65 Jahre alt, in der Elfenbeink=C3=BCste, an Kreb=
sleiden leidend. Ich war mit Herrn Johnson Han verheiratet, der bei der Reg=
ierung von Elfenbeink=C3=BCste als Auftragnehmer t=C3=A4tig war, bevor er n=
ach einigen Tagen im Krankenhaus starb
=20
Mein verstorbener Ehemann hat die Summe von US$2,5 Millionen (zwei Millione=
n f=C3=BCnfhunderttausend USD) bei einer Bank in der Elfenbeink=C3=BCste hi=
nterlegt. Ich habe an Krebs gelitten. K=C3=BCrzlich sagte mir mein Arzt, da=
ss ich aufgrund der Krebserkrankungen, an denen ich leide, nur noch begrenz=
te Lebenstage habe. Ich m=C3=B6chte wissen, ob ich Ihnen vertrauen kann, di=
ese Mittel f=C3=BCr Wohlt=C3=A4tigkeit / Waisenhaus zu verwenden, und 20 Pr=
ozent werden f=C3=BCr Sie als Entsch=C3=A4digung sein
=20
Ich habe diese Entscheidung getroffen, weil ich kein Kind habe, das dieses =
Geld erben w=C3=BCrde, und mein Ehemann Verwandte sind b=C3=BCrgerliche und=
 sehr wohlhabende Personen und ich m=C3=B6chte nicht, dass mein Ehemann har=
t verdientes Geld missbraucht wird
=20
Bitte nehmen Sie Kontakt mit mir auf, damit ich Ihnen weitere Einzelheiten =
mitteilen kann und jede Verz=C3=B6gerung Ihrer Antwort mir Raum geben wird,=
 eine weitere gute Person f=C3=BCr diesen Zweck zu gewinnen
=20
Warten auf Ihre dringende Antwort Mit Gott sind alle Dinge m=C3=B6glich
=20
Deine Schwester in Christus
=20
Frau Theresa Han

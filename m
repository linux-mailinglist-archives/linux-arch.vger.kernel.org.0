Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3302951BD
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 19:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438121AbgJURrc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 13:47:32 -0400
Received: from sonic307-54.consmr.mail.ir2.yahoo.com ([87.248.110.31]:36408
        "EHLO sonic307-54.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390179AbgJURrc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 13:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603302449; bh=1SqtaR0RuVNnVzX6vsbClO+irZ/7+uk0RKtHRhAiloA=; h=Date:From:Reply-To:Subject:References:From:Subject; b=c2gt7gWwyR1hydT7YczmsYHrpzln8DWEAza2h4IX8jtc8ogHyrxXM9VK4luAyoXkp72G/jW1NWRMaqHwn+0myF0dY/TzYxqareW3wOgeP/ho0i/h2sBIsqtUQEiL+F6APmpuB5ILU/UeuKH6Y7TyTk/xqPAvH7ocSwJXTmVPWCKNVojDAg1QlDNdNVCa4Lw5fBFLcciEKWykjkyHkpX59JkXnOjuEH/Kwzj962v+rAKP/gCFXUMwyzKcbQopglm76jWiKaWaXbctHIXO8FCsK766Mkkwre7fCYtVu4eLn9UwXc1qR6DqY1TMiFEDZpCyu9+rrpHaUerrlGfKUz6ipw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603302449; bh=RqCW+117ZPZqCXMV3Tsp2aET2/PUjt9/B3qfoamsAwV=; h=Date:From:Subject; b=J3rLoo1af0GqzTp/qWayQPtsa5r2fCmkKneu7oQk/n7haBR07tSs/taqcktw0x3wKZ1g+vKa4IfdMTj6FvwQLN+mgDaEzkCUVgzHcvk9ov1iLubrBq/WS3UNYJw2enhUXqJW4WCPxl5FqTDM6STyNDmukZhZTZ7FIBaHFK1U1fQj5kp2+Ql8qbPweGEO9evMv8pEPc77fWumXPHwaevQ7EQ3lyJ8P8etawUYmNRpAIEZQ3jc4VxA3SSQrG4MGKzqp+8OMZoH/NUbCVJosCeJnkwIVhbJICN50M4AV2ucuy0zlYELoZpmPdb/bykdLTMvocdO2PlNrNeX1WVY8p3FQg==
X-YMail-OSG: wL6naJQVM1liqigevGJ7yxW06MFi9MjYSgaYlMv2aJv7Mf8.azgehBbInCkGSCI
 S8_ZvIBXi5Lb8mengllofbZWLfZii5TnxI4Xgl4yl4n_aXtfcFdl38fmEQvd02Y3iv7VQqUjmTOT
 oQXCoUNSvHgofJXwlwnFfedL0Iz8afz_i6ms2QX59Z9SIjfKKZtrlehjXiQndUgmoYYh6lVm1Dec
 pOxxlcDB5fkT2ZQKpJyhfbt6QO5kQ_iOak06851WltvALS4V1vEmd4H1m8GrXduaE7pZcKYkB5fR
 Ji_fp7uCrlzHCOwiduBuQGYXqJ.b5gAZccGuR4Vqxg420b7.N6lmC.EsNwRdxdCgSRgL7AD8cqN8
 F4QX7kMEYX29lxOZYD_QIFcJP4dokMc37xT4zri7OhNs.Vkot3oNeWBnXUJOBk8y9jOXMyDAOuUv
 Tgc3T9BX5RIHRTPMTJEJJ_dz6RjqBItkOIR1hbMh1ucOGpQ_eA7sLrHknQps_KtW6wWbw7yqhe9D
 ESbjLry5zdF1M6sZUI3P0iKsjwoHkVPjkewccl2q.cCfPf5yndsLtCCkn3cSuJYWZWTJocjDqYss
 HRMkM1CaiIkw36DT_SgLTxtL9fwG6Ax0xOvPlgVlyWHXAJbgiWDLGo9TZPYJPIlEJYC0ytLgeQ6d
 FI1_3mMD6iNWS5YzNe_d9CJR6trNNfjf080YeRE4aVdKZ7z4T09T8R55sEI39v8xAteqK6RIVCuq
 .tTo8Qxo0CzKaSv6c8t6UVydiV9XG.2d2t6UdbHciPmT22_1gzTsMOdO430W.dVC698VHVWuP8B1
 AG25vfdRkq90JC4mLGTALP.TJ7P_q_51qJEeormiGhzFBIKU.BoLx9zpC0WcBWnr65El8vfaSn9d
 V4LYmP.K55l3fyEvwScnHZnz6O.4DTlnp_BMak9zakfisxjnEzDx25ouEfxbOMDkn9FOE.26JYRW
 KQ9dUUIZPRH0mAp2tH8J.ZFHlJRtukZtC3gqgdL8yoxaFqTiTmDzvL3ezOfvd3s6I8MGdMYyamKm
 UtkPDxc3mlVssxtSYyRrR7yCNdoApo5xOL9SnNkJrZeWotQqSrNxStuV0DIP4mpJKmAyfFsWPDhO
 hLCX686Q_Xh_kXeMZSzzNewTI7EmuD0N3uStIVEQiZdYKtSyvdzLLCAY7Lr3etNtxoWTsSLo1PXb
 F2_cMJHWpEBkCwAFPLro4DRHjfBq9d8SyJVkwumbDV7IeVDkIlyZnMYYxScBZNyDkIF0aAKYtRld
 5zqHyajL0.UWGGERtPAR7ulUB6aEwLLbcos5evmTEW1og_fOqE55Eo8_VAZJUO9zBt_ac68tvCH6
 FRze3paXPXChuUdTjmO9B0DCDLfqBPqZmJTYZfbCQ_Pdpjltf1d_.rgA5Q6Gj8kFD5h8xws8n52m
 YR93JClEVEzHyXqNekNueNwjLBulgrVjB13SwPGLBkCgXaWaU_Ukbxmmh
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Wed, 21 Oct 2020 17:47:29 +0000
Date:   Wed, 21 Oct 2020 17:47:27 +0000 (UTC)
From:   UNCC COMMISSION <unitednationsrecommission@consultant.com>
Reply-To: unitednationsrecommission@gmail.com
Message-ID: <1934374546.3156865.1603302447742@mail.yahoo.com>
Subject: UNITED NATIONS FUND RECONCILIATION PANEL,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1934374546.3156865.1603302447742.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

United Nations Compensation Commission, (UNCC)
Branch Office Un Regional West African,
Regional Un  Branch Office, .Secteur No
Bo=C3=AEte Postale 135. Ouagadougou 01, Burkina Faso,
TEL: +226-57 70 72 36,
FAX: +226-52 53 84 60



ATTN:

This is to inform you that we have received your report directed from the W=
est African Economic and Monetary Union. In conjunction with the World Bank=
 and the International Monitory Fund (IMF) We the (UNCC) United Nations Com=
pensation Commission has agreed to pay you the sum of $ 1,000,000 Million U=
SD for your payment notice of your hard earned money spent to various group=
s in pursuit of your Bank approved Fund.

THE BANKS,

(Bank Of Africa, (Coris Bank International, United Bank For Africa, Eco Ban=
k, And Central Bank Of West African States (Bceao) process of your fund cla=
im which was not transferred after due process.

Your names and email address were shortlisted among the unpaid claim custom=
ers which we discovered lastly. We really do not know what you actually wen=
t through but this is an Approval payment from the United Nations reconcili=
ation Panel for you in order to protect and guide human rights to maintain =
a good international relationship with your country which has been very sup=
portive to the African continent economy growth generally,

Be advised to reconfirm the receipt of this notice and forward a copy of yo=
ur identity card for further process for your approved payment to take plac=
e. Please do not hesitate to contact us by email or call. If you require an=
y further information,


Looking forward hearing from you.
Yours Faithfully
Mr. Samson Makhetha
UN Regional Director General

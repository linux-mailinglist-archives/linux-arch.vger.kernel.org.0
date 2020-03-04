Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA6D1795C6
	for <lists+linux-arch@lfdr.de>; Wed,  4 Mar 2020 17:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgCDQyZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Mar 2020 11:54:25 -0500
Received: from sonic309-21.consmr.mail.ne1.yahoo.com ([66.163.184.147]:46834
        "EHLO sonic309-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729675AbgCDQyZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2020 11:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1583340863; bh=TB/VZc/UhGoo0+B79UC9Tgtg0pigPTFcBcEvkMbFOow=; h=Date:From:Reply-To:Subject:References:From:Subject; b=mdtofm6JvZ3HpB0/7eWbXYpseDJiuBWp64lFNCN7wqF2dMBJBBqghVYU4hfznIXiQ5fAwAuI083i2Sf0yFEt5Q7hCGp1HbRdS1ZU6jVHhqsh6C2n+h/j74jNXAPSfmrSHYrl4KeP01k0UOPGiHNnk7VsuQsiGMOiEUnW4YzoAWhYD3oUhZb/A0pXZuIyuJ5xFKkFrbKEr0PBeJlfLRTsWA/JIrF2eSpGZKTCKB6a65lybwhAaWLwy9jobcMu4DEVe/CT7BqHdAsJfPMle2gGr71qDC95nLwG/85NBjh1uPwSeNB5syGLS2ZDSlTC1WsBvXuDv95Na/RK6s08nbfV3A==
X-YMail-OSG: ulqL5o4VM1mMNYdq25tGforsat.BC62SDWoQ.fvCFz9nCa9cVJaKQzcCuKKEEl6
 yVGt4WlE_DOendEWBRcn.lViONTbtZqaVVtXrO1AKkmcGq_QF3nUpKSaS7XTjdHLQiB_3alZ8NM9
 OZQMSB5z_Ni1uBFmAqQfUrFty2scPGJT9pNKtzHdkEsivdRggab_Z2iPGnhjPRVqIlGUeCohtceT
 yainQrQC1sp4.384cmMkWPK_HxEMe.bLDzqyqELt8c4DTDUtwwJfH5z_tu7t3y8S6USPFVDJVi0W
 Q81AdZgBixtMomebIoe0vzpUIPUSTJUsdt8hWEYYw.DcuZ3FS0s_JbV80nD7SGLwpkrILkz_WNnb
 uxd1ZISZH4hmDNG8SMGdBIijRDQyT0_ckik3OKWJf16aaavxl09kpcFax.rO8wcfAgFIkiX4snFb
 Rvd.2tXcug.jz6hjGjC6jTOMq9sEJXET25mRsOyRPpF.LqHntPBckzMgp.HOOhoz3Pp41tcFU1s3
 J_8ls_NLUXwaFtpEHWn4fmed9jbOsVD.Dj_ZcLdB_Pmb86zO9mwGP7wPxWcblMMlpMB520QAUKK6
 jJ95zxGNOLcT7BiBc046ldCRThLnxGK8bZRLr32ZUxDTGzfMR5Syd1xlE_ol_lSrfNRVYaBK7Rpz
 HjsUl5GAkCNHrEoz_ZmTZrXAFAXjqf8sOvSw0O57faeskm7Lr_6jhri8WuZUB5y7m6zRVkKxwVWD
 rXakYc8rrULnT7ayrrTkF7oeGlkh.TaqIU0rwSuBrRAaEB7jlHHJO5zm293KvetF29fFa0h9x5u5
 rvNqKyFKWRnlaIXTZoFv3gze8W436nHYPIS2ZpkzsPMMLAEtUI0yHpW0K3e0Uv7QQsm0BSa6NP1T
 3xMwCkGsaMfOK8vBZ3sYdwwjVYGbbYk56LFoyt50ZyPNQoC52F4NpGIA.5HrfKktPWHO9zRynqhG
 jiI.VDWLQ_WXy3v58uTvXBzksVeIZzeqt74Mt8eHFpD8Z_8a5Bizif8POdUo6HwDyYTWyO3GRhYy
 eTHsUviEGHo8g1PvqxoWg3CAXIHkBDD502cwOB0X_wdUtYVodu5PN.xwRv.18MQl1_TFwaOddaqt
 xz0bZGR_GwqnlCCWGpCoWP4g2YiXnpe4FjYFXotJ2e9YZYCzrduEW6kkC53clC3it.hkcJijaycC
 0gbNnit_FvLoDsncZZMUeVKG3Dsst.T0Ce312ABhJImT.ubKObk05XxZixXVPmGB3G53A_CVJshC
 r55uW01DFi6ldS4tyZrhtwM5kHDuO1IkeNSdZQS0RRGU1w4vP4DZRCiRUt5phmau9sWqEgaoC0rH
 8qN3QdefTj8qqxtlGLwiVEgEJBlc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Mar 2020 16:54:23 +0000
Date:   Wed, 4 Mar 2020 16:54:18 +0000 (UTC)
From:   "MRS AMINA KADI." <mrsamina.kadi3@gmail.com>
Reply-To: mrsamina.kadi33@gmail.com
Message-ID: <1668171133.4336166.1583340858647@mail.yahoo.com>
Subject: COMPLEMENT OF THE DAY TO YOU DEAR FRIEND.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1668171133.4336166.1583340858647.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15302 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



COMPLEMENT OF THE DAY TO YOU DEAR FRIEND.

 I am MRS AMINA KADI. i want your assisstant to transfer the sum of 5.5USD into your account, I will give you more details when i hear positive responesd from you,

 Please contact me with your below information to proceed for more details awaitin your positive response.

1::Your full name::
2::Your home address::
3::Current occupation::
4::Age::
5::Your Country::
6::Your current telephone number/mobile phone

 contact me with this my private emails I.D (mrsamina.kadi33@gmail.com)

From

MRS AMINA KADI.

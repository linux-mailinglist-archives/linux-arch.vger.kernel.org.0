Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331B3203BD7
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jun 2020 18:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgFVQCb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 12:02:31 -0400
Received: from sonic302-21.consmr.mail.ne1.yahoo.com ([66.163.186.147]:37364
        "EHLO sonic302-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729777AbgFVQCX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 12:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1592841741; bh=cK2qy9Lv5SAgMg9nAvfVmkJPj46H3ss3vOVyjpHm6Nk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=imnMzKvnrwdEkzevY9v55JCHWrS7mFcRp2xLflBpdsWBX5v32iTt1Jwj292Sqyxc6zTWfVf6UW3RltjDxv8H8ZAxxFg96tpPBoXA2f/GRkfTuiNcUr3yDzOGiHeT9IqR//B+9C8c9YoGDJPnAeuuKcQvLl1HS8J+STK4/r0WZ3jbtWFF0MKDjydg+AbeXShoRDHqwsqAaAi7D9jDq8wNDWBIR81puaAh7APGDPK32RqjpFS85hxXrbmotW59Gm/gC9SoLB52q4udtwMI++FS4HYmIHt+kUh9tNcMAsNUvFYo0HWMN59EiLf7lYGm/4AR40adfmghUfkmt4dYpTZmZQ==
X-YMail-OSG: AhKkJLAVM1lDQ3XPPTTJWpEw.A_YPk4v7tBrtMEv9XTYrBN0vKxPyUyPokZyCLH
 0NPJEnbM.Ixt5u0eXkMwZesEBqS.rCtCLJgnod2Yg.I9TXOm0suNzcmJ92mBaA3mHgRFUusjI.6E
 3Gu4LEq019.le8uhDgpgUZ.YgtmiKAQJK6Bd4WPLqozbdEc8urSPipLpvwJTvKec65xmptWyRiVv
 5wejfhjut7ltVV2EWvbGnxpPsKrHXW63gZY0z7W.qC8yTTTM6xXIAPM6OYdYDYNn.6t5yJFWlC1P
 OIdbZEYbWLsjaYGAZ3nhw68imywZs7JgVqTzxfR4ZQQxpuo3K8t9CM9O0hpOCt10FP__XXwyrmrD
 TCoCE7B_Edu3G.zjOUn_rksR4jYB.m1Rp.1vZ_bLxnQwCiAul5Wqfj8PNdUGzT.zvxnBCUVqWq9J
 8hXM6oMyn8gklCF.R8KCTVo6NRJRq4thjGWIexrpJEGu0QolvkJTIALFEd6_slAReLmAOEup3xKy
 .77XY9y0L2WZlQcf1QY4ryEv90HkLK9R59Zd1MxuC8qefRgY6y6xUFmVBWO8SDJCCjnQpB48PRDP
 pRTSfD8hEjxrcMoyLQRR8ik6SRBEuL1N.zoJ2juJT7TtdJItukcqyaFlw7VOC6cm49vWb13NtnZ0
 gQ2bWEWTG5v0uAlc54_ulltpKs.Fgm6hkagBtyzunEJ52PGAuturV.LPWyLoBYPiB1KC1HlV8gI8
 yJqtTplsyPL2eALndgi_xv5WXRslUdVun50zfx9iDK5v_kT1lyZrnl7BpPa5N7roHYs5FCR3fGlt
 00HJ7sf.lnan3Im8PEbT96k38NwI6o6wqQk3XTx1x0TOib38VwKLgaWNY916uiRI1upzFCMVqmW6
 hKW.i_z2qDWeeQaZVyBhDmfLTpSCKpEZXqJt.HWEa0uB7F6lyRoT1rQEzhMY_zbISz6YbRmtNDlq
 VLlEzjYA6uILpMVD7EkmwXGP0XOJgDIix93HShigByDXDbmOlbnVPelpKvxPRFg3gnhpf.0Rc47i
 08Ic.liUMCD9zHGFCga9cXgoGaM8kFbRyDB3CB8uLHuuV8rIwOstkm24RLt0t3H1wtfuP85AC7r8
 v042NbRsPX1Mj80LTxFt.KStV8ND4Dc1.IiPBslhVUpEA9f2YrGnkjCHG4.U4j0M0U489djAouYX
 y9F8lECiGIH30pwUi5p9NUzViYBtaTM7ID67rbGjIKdkEdFs14rCm3KSzct0U2izLUB1NerwsRiF
 IQWasnNhp61WOxqpf4zyo6bEJMCV1B8QkTG.8HvHCcJtAwYQhWHkE5SwAzxSGopkwGBC4.Xf9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Jun 2020 16:02:21 +0000
Date:   Mon, 22 Jun 2020 16:02:19 +0000 (UTC)
From:   Karim Zakari <kariim1960z@gmail.com>
Reply-To: kzakari04@gmail.com
Message-ID: <1507214802.1850985.1592841739314@mail.yahoo.com>
Subject: URGENT REPLY.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1507214802.1850985.1592841739314.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16138 YMailNodin Mozilla/5.0 (Windows NT 6.1; ) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Good-Day Friend,

 Hope you are doing great Today. I have a proposed business deal worthy (US$16.5 Million Dollars) that will benefit both parties. This is legitimate' legal and your personality will not be compromised.

Waiting for your response for more details, As you are willing to execute this business opportunity with me.

Sincerely Yours,
Mr. Karim Zakari.

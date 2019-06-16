Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F3447315
	for <lists+linux-arch@lfdr.de>; Sun, 16 Jun 2019 06:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbfFPEnn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Jun 2019 00:43:43 -0400
Received: from sonic306-3.consmr.mail.bf2.yahoo.com ([74.6.132.42]:45027 "EHLO
        sonic306-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbfFPEnn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 16 Jun 2019 00:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560660221; bh=FCjWGTqDRXQUUN8ivg02MDhbiDKrvltOcpc7W52q/3U=; h=Date:From:Reply-To:Subject:References:From:Subject; b=SgdPzyJc1fTWaoMiYDNHLnMxjFx3dtdm+nllARPJij/smmXMaz1qswx6vgMwttItpYtlSxPVAeFZooV2y2r47FtUKEragxYywnEYpribWAps7fqIlO8o+Wt0JBTeqRObX4O1q+QvJeMCJxqsc9b1Vd+kP5XOkIqZn76c8vTlAuiRdTXjoGMDY2exeqF7/VhM4hfVldZkY9uHsJYA+i+4muAYGmqAQylE6v/aw77KZH/I1wXDAJlbj8MP9DnuxTMPZTYGtnC49c2Sgh2G7/hiI1PJnhcUE1U250YUk6lbdEOjY/r6S7jslhsWip2lkZvie/6CyZeAWjQNEUb+Z74bdw==
X-YMail-OSG: aN4gmAAVM1nA9ImZlfQL6FHT0Igk6.8SLjKFfJV2t791tQYINpBlUpoagDpmOC8
 FapLCxXYWTd4BCZqxEMU3c5qFOFgrYBs71dqJkqVr3EZavkC1hFHyynkdQqIZ1WkWgMKV1rzdwal
 NQSMADngeglRNV1eOwYAVhMUVOfHle3c.KzxlFCFw3o6nCKDwcYkRpT8S9C6udX_WtSqLEC6..tl
 EZmgOyIfdcot7oSVQVG4Fzpn2eIj0cNBDSwbOQr6.wsY1jyHVJjxGwdnu16Emddb_0IeHmjh8WhW
 hRuDHboLRS5mOVtaprBsAv8oIpjwOlVjVSGnUNUqhWM.hRXiqJCXoJzA__qMqdC4O3N17v.jEwqS
 rgVeTlG7doGbBVZYoFDLPHr3AD28SVJO7BHXy3s33WBZq_sYt.Z94CcA.Z34RTEKi0t5huYw9euT
 X47v_wCkqUhr3NvX1ZuRZJVpVesE8IUSrXA8BwrJwWZv9UHgvBUY6I0jA2IKqQK4AIK5cabDrHfJ
 Gvq7HdSespz7Umyl3D6ug1E.ktnKt.XivmqzxX.Jd9V9ZEhFGQulSXj45o5fKBuYJqxQUp0KnwNm
 xSM8lDsTgM9uYi1eZAaDZQ3RUctZvtkkg7k4Kq9G9fmzTuWRd8Rdo0YzImpeMkb55Mc646WMrYOI
 LGAh9gQW36pCEUWVzI0ph7ndgVr58VsyVBN6q0n.MXEKx405.09XgIE4a7CgDsLowWqm3Gdrl6Gl
 VeivFItd.HvVTsIO2JEygvpmFRYnM8FvKSKqwfYnHLw2HxKNVu2ayN.nHyAfOP8stPII3vu6oQsi
 PP3x376CGtaNBZRsxEq1M03Hb4tMoofoqHuK6UlZL9c_uWlwxgBbMigs.f4.fK8o20oMoPyZEAmy
 evZaPyAR4qNdETJp3NR60wS6wabIZVKfiiyOyXgoqFFSKQXKJLsJII.ABwstDQbvdInq9KtLH7dd
 Bnq6JB00xctMladlnlK2QJTmTUJh1KXeriQj3wULJbhP0bPgYtWaSNENhm11knjMgTcLWp_m_afb
 IuIAnPoe8oQ6gUnZDg.mmrhGUPvsqMVC2KoU_H6Shz9FCK_.ScXm4d6rp5u_DAM_xiKf2QoTYhbZ
 N1LEEb6JnnRp6Q7xghEU1Xew1QXxCM6RpJ3OocbuX2LrEK4jaBs2Iw6HlXEI_J_jZp7YIhZaBf_C
 zpcxPmTcaIHH6HK3kq60WqRx4NtZlD3DHsrAMV6avtquwWHfKYg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Sun, 16 Jun 2019 04:43:41 +0000
Date:   Sun, 16 Jun 2019 04:43:37 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh101@gmail.com>
Reply-To: Ms Lisa Hugh <ms.lisahugh000@gmail.com>
Message-ID: <312794937.1566253.1560660217897@mail.yahoo.com>
Subject: URGENT REPLY FOR THIS BUSINESS...
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <312794937.1566253.1560660217897.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13837 YahooMailBasic Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:67.0) Gecko/20100101 Firefox/67.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Dear Friend,

I am  Ms Lisa Hugh work with the department of Audit and accounting manager here in the Bank,

There is this fund that was keep in my custody years ago,please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment and the amount is  (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me after success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other .

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.


Ms Lisa Hugh

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8134C270FA0
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 18:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgISQsD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 12:48:03 -0400
Received: from sonic315-20.consmr.mail.ne1.yahoo.com ([66.163.190.146]:40091
        "EHLO sonic315-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726434AbgISQsD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 19 Sep 2020 12:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600534082; bh=fB90K+9O02P1ViQM/kwbkjQJZ5yP7WeTCC4tmdR6z2Q=; h=Date:From:Reply-To:Subject:References:From:Subject; b=A5MeQm32T8gxL9vBO+jHjorEl6AKsDa9T5VZQCyoQV73EErIIvne55kUJOAbmnxOiye3iM319nhfW8TWS8Td0YOV0mdI9oCiU+p+VuChMXb6tVsvNMWqoFz/9W4a8RXbri3sXykpSfxDdS7N/nOUzoe+g2+21lt4/apr5SRoW8/Gpkw6w1fGZOTS9mEowHsa1nttnAAe9WH2pAo0uTV2eyxQh1UhoQAFHppC/r0z1/x/eu9JiYL2v0b+bsHZP53bVtsM3l7hC31zsLCot5xUKYSOk7h6ZWveT77mnshq9zt4atZkGyAX1Gl0z7LCHp3K1VQPO8IP9KD4TT48nYUZog==
X-YMail-OSG: vv3NVyQVM1lLrAqoEhHppLFIQE3WBuUyUvS4heypW4qE0BgBmIhSEeuhvRSQrnT
 PlyUUBDhfK0UmdbviCVEN3NZQitMeLMt7YOR90Pyl2YPy3uC2X_LPu8v9pQTzYz96UwAld4QIdlM
 PWYtgX4yiGeIeqhPVPTx4xXwgcxc0.6VW6_DWa2GCAzMNnaH6Qd4uPp2U9Dnep5.iOAQ0SBb5yWg
 VqDideJf7o3LnTLWyzpTPrSpLE_yB6cmah7yns_W1TNRDjWcrC9o5Apo60zfIxqRo.SVJTOylgy7
 zk0jM1STzOYB10KidpHLsOpg5tENWqNS2HdmqfMqy_OicpwK5q2w9DziNa36ZSlFZPwMuwBkL7Z_
 0s5fGmPzoA_PJlX.gABYLMb1ve7M9aXhUmqZHugHkmh1SiqZR.ZKExdpvkFcwdPKiMfxNOa.eOzj
 rWTO_ysqdPhdK6gLvd6Z2YBowPVzElmLU36S48Yew.Xw2_6ekGY.2N08FWnYWUTVLsjJ6N1JvC3T
 sCO40OwVafcP3Z3LHaMpwoWk87p1VIQgX_6Sol9cHL2a6hk4Jrwj8FdaPJqCwnBSCSwEdYFnHWpG
 M2qAldh35WL0cXcySrgS2vh5ZecfbjAQgBe7cvE7MZmutBvidgD.oHFq4lvQTvTcQW1.oeJLjeoB
 L6R3Kj68Mj8BxPUrJqTI2HNS7bcm89svsdOa44cZ1rv5XuObz2im2u.v.AHKMnVM9ZIvc0rvaVn1
 pinnW0LZoR0wuJLnFqbI5Zv19kWggBLtRfJF_mV1_87D9kH8rCf9AxLvGb8fh2_Oojl_gRZLYHOX
 PzDyeD4ADmx8rl5_jqQXgt5Cyu9TX68TR1uaI4mA_b_qOxw0dqbFa4zavccOF47UghkAW4nq_5nb
 eewgQMh_6BFXO4409.qmxEJuF7FvcdEvzzw4p08UE6mqlWm1I3FfFwec.3V.r8sEazQqmyaOBy.U
 _gd4n50LI0SO3MvS.3tPpJHkFj0zcGIx8Bn4E0RiNc0JraYadr3Ff1_mZWuG61Dr8nG8X3NKIvD2
 I19wsGN4l8Mgd3Bf8IiKJ7Dmx91J8KpTsxoGQKBn6G.4UvRY0btSbjuVGc5Rd3pAGnuwthNvURJ9
 WxDSb5MfnWmh8L2fB335oS.Y61fZgB9rb3qKMVRC2zvU7i8pSo6IspuujxE0hj_MCV3uJM09IbM4
 jLzD8bqV4sh_E3kEX8acx5NLHli1ATa46Vye45XSi_SPPdwLrKyIhZfWIDXd9tiFYeoRITaPKusT
 wrantCd.jMTFQLdI7_Wy1oTGI1mXyaG_5KUGKc9CF3FOfA1YzjyIQ3Zxv8GQxXiMhvGk1XVWaEsa
 XSnwFlVV0.oPUkJTjU8iKuiiZ8GJC0Mq0sOHsOhEdy1CVuA.ok2ZS0eyfUVmCYfxc67bmmbQyE_e
 TrQJV8M.pJooAjnyA89eS4VQ0hXcRQm_QRP77iyJ__98kIbCdD0srftH7_mfZB7A-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sat, 19 Sep 2020 16:48:02 +0000
Date:   Sat, 19 Sep 2020 16:47:58 +0000 (UTC)
From:   Sal Kavar <salkavar2@gmail.com>
Reply-To: salkavar2@gmail.com
Message-ID: <591622745.4245246.1600534078004@mail.yahoo.com>
Subject: STRICTLY AND CONFIDENTIAL.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <591622745.4245246.1600534078004.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:80.0) Gecko/20100101 Firefox/80.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Dear friend.

I assume you and your family are in good health. I am the Foreign operations Manager at one of the leading generation bank here in West Africa.

This being a wide world in which it can be difficult to make new acquaintances and because it is virtually impossible to know who is trustworthy and who can be believed, i have decided to repose confidence in you after much fasting and prayer. It is only because of this that I have decided to confide in you and to share with you this confidential business.

In my bank; there resides an overdue and unclaimed sum of $15.5m, (Fifteen Million Five Hundred Thousand Dollars Only) When the account holder suddenly passed on, he left no beneficiary who would be entitled to the receipt of this fund. For this reason, I have found it expedient to transfer this fund to a trustworthy individual with capacity to act as foreign business partner. Thus i humbly request your assistance to claim this fund.

Upon the transfer of this fund in your account, you will take 45% as your share from the total fund, 10% will be shared to Charity Organizations in both country and 45% will be for me. Please if you are really sure you can handle this project, contact me immediately.


Yours Faithful,
Mr.Sal Kavar.

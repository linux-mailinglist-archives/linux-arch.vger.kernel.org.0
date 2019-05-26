Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 092652AA85
	for <lists+linux-arch@lfdr.de>; Sun, 26 May 2019 17:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfEZPt7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 May 2019 11:49:59 -0400
Received: from sonic306-21.consmr.mail.ne1.yahoo.com ([66.163.189.83]:45445
        "EHLO sonic306-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbfEZPt7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 26 May 2019 11:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1558885798; bh=FCjWGTqDRXQUUN8ivg02MDhbiDKrvltOcpc7W52q/3U=; h=Date:From:Reply-To:Subject:References:From:Subject; b=p8lV/joolu5crMcaFYOakgmMEXSU89ws7n+JxmWxYjDIVEF48pKOyskhiN45IJizMT61U5moQTe8HP2maQVJAlG8Qtx3K/KT6fLZtQPBa6/bIoNscswy2srQR4T5bPOTZgp+wWjunBSwnHBoRrPS9t8y7CRZB4qXRAWeyVSYE74G/zvyGp2MhFb0yScannxyTPlI/WTwc0UlB5Fl3B/rFrlNvoZnEziNH9la3PRQxAOoiG21negz/TDje4F2J1dEViNh91an+HxV3+FGXW1sNQpc1rmTgy7Z7L+i3yuIJevEBYc7VUwWvM7/HuuLmVRSOl0QMPCoWP3e/SiJzgWbqQ==
X-YMail-OSG: jSfUWIkVM1lFCYK2YHcwT7K9xQsUl0Oc5_Rj9gT5zxnNnlRgmSn8iQeq0yZfamU
 myr3yILo212nkdrY59dfpg3OZyCKYecKvhX9TzGjtGcti2zne8LZ78cBgg4lC64kl0kY36DOpbGi
 jOLq3DoHJ2gunI4ryTh7Dsh5mQnkFp98_CG93BKGI0H2FrOtycoyjXPcmzgskoFD5GC7wTv2ocRJ
 hQbRKqmQfWiIa.B2f3NUZ2DGstac5LEx.rUt6yOvHAaRk_0j8eOjGyF0J2g5bogQZs9jfk4kJW1R
 MihmgA6YMWbzAbnGPwD7evZJWYAisVl4tcEwpBEeZ7FnzlvAVImIANL6v2IMnJJJJ8zkipXNuVjd
 yCT44OmhDHXTvFWbmuZIP5.8QwXt3Y7HEiLe66dSva7T2cuIHBBAZGg8cQReuiom5dkzGdJxUbBc
 INbc0fWCVLLLa7Tv28CTzvdQYMUy1Bd7mvqpqScF0RxKy7_IWXQG0yU2X6HpdCFQcZTarINwHBeh
 asGoer5ZWl4ucpv3UJ7Aq0t8AQhp.FLR7TM3KpOPRzeeS9ZRHyfM_O4Q.2Wg12XiQA0A6nhh2n3Q
 9QNWYlrW_ZDltGlTHjpDHTcbFW25WCTfNTvS5xSz5aUJwZzj1rsaFuFC6k8OJjMhZH_o8QSAMi89
 _jXEiVLAUM1jTBiVXO0TvnJKEYhWoEp0JpYBLEA1AFBCbwFecWbnGomhzT9NRak4jp4pDn6Txyys
 1_Zzccc069LRuGaCXN4aqjucNU.6QEp4J1ZuFtTtE3t3ko8NmPVWfmV_4fhYmvXgIhNQqYatqwfu
 LW9GApOchXgEp.LIkF82Pt.z1.zbX2XT4Q2p2DRrwf4aRdN0Yb7_3PbERZvq_O2IG8cQIIvz_464
 WXD67JdSC0l8rOS7XO5KqMeA3e5jWTQfHKVxjlv1Uom5flGFJDCfPp.P8IVMUr8e5U9q9YM7BKGv
 UanDm_dWtPGZ4BHj2xFsCjWjTkic4.hEO19216bs0TsV_DkZU.qnH1ax15vWctYZEwx_OtWDcyxV
 qGStZINrCpneEGjI2Z8prM7zXcp9AtL1FuzYJ4TOBhsj2ElIrZD7KigcBGY3KrZaOYCgGaZoyRH1
 WYmzfYMdJZpCoqnL3vYRHBEmkPj6GDAGitWNF8Q88kR6c7CvDRftv9YuATFiu1fksRtsA_SCuszh
 kvBWeeSh1oBMMvYoMpadegIq3wjpUsGO_xjkCy22QnhLNUrwbDO7PndR9s08-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sun, 26 May 2019 15:49:58 +0000
Date:   Sun, 26 May 2019 15:49:54 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh101@gmail.com>
Reply-To: Ms Lisa Hugh <ms.lisahugh000@gmail.com>
Message-ID: <855196847.7802943.1558885794550@mail.yahoo.com>
Subject: URGENT REPLY FOR THIS BUSINESS...
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <855196847.7802943.1558885794550.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13634 YahooMailBasic Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:66.0) Gecko/20100101 Firefox/66.0
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
